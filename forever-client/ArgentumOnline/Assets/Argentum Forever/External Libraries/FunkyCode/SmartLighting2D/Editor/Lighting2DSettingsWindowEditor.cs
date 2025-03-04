﻿using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;


public class Lighting2DSettingsWindowEditor : EditorWindow {
	int tab = 0;

	static bool foldout_commonsettings = true;
	static bool foldout_daylighting = true;
	static bool foldout_atlas = true;
	static bool foldout_buffers = true;
	static bool foldout_sorting = true;

	[MenuItem("Tools/Lighting 2D")]
    public static void ShowWindow() {
        GetWindow<Lighting2DSettingsWindowEditor>(false, "Lighting 2D", true);
    }

	 void OnGUI() {
		tab = GUILayout.Toolbar (tab, new string[] {"Preferences", "Profiler"});
		switch (tab) {
			case 0:
				Preferences();
				break;

			case 1:
				Profiler();
				break;
		}
    }

	void Preferences() {
		Lighting2DMainProfile mainProfile = Lighting2D.GetMainProfile();

		EditorGUI.BeginChangeCheck ();

		mainProfile.profile = (Lighting2DSettingsProfile)EditorGUILayout.ObjectField("Profile", mainProfile.profile, typeof(Lighting2DSettingsProfile), true);

		if (EditorGUI.EndChangeCheck ()) {
			LightingMainBuffer2D.ForceUpdate();	
			Lighting2D.UpdateByProfile(mainProfile.profile);
		}


		Lighting2DSettingsProfile profile = Lighting2D.GetProfile();

		if (profile) {
			EditorGUI.BeginChangeCheck ();

			profile.renderingPipeline = (Lighting2D.RenderingPipeline)EditorGUILayout.EnumPopup("Rendering Pipeline", profile.renderingPipeline);

			if (profile.renderingPipeline == Lighting2D.RenderingPipeline.Standard) {
				profile.renderingMode = (Lighting2D.RenderingMode)EditorGUILayout.EnumPopup("Rendering Mode", profile.renderingMode);

				if (profile.renderingMode == Lighting2D.RenderingMode.OnRender) {
					foldout_sorting = EditorGUILayout.Foldout(foldout_sorting, "Sorting Layer" );

					if (foldout_sorting) {
						EditorGUI.indentLevel = EditorGUI.indentLevel + 1;
						profile.sortingLayer.ID = (int)EditorGUILayout.Slider("Sorting Layer ID", profile.sortingLayer.ID, 0, 31);
						profile.sortingLayer.Order = EditorGUILayout.IntField("Sorting Layer Order", profile.sortingLayer.Order);
						profile.sortingLayer.Name = EditorGUILayout.TextField("Sorting Layer Name", profile.sortingLayer.Name);
						EditorGUI.indentLevel = EditorGUI.indentLevel - 1;
					}			
				}
			}
			
			if (profile.renderingPipeline != Lighting2D.RenderingPipeline.Standard) {
				EditorGUI.BeginDisabledGroup(true);	
			}
	
			foldout_commonsettings = EditorGUILayout.Foldout(foldout_commonsettings, "Settings" );
			
			if (foldout_commonsettings) {
				EditorGUI.indentLevel = EditorGUI.indentLevel + 1;

				profile.commonSettings.darknessColor = EditorGUILayout.ColorField("Darkness Color", profile.commonSettings.darknessColor);

				profile.commonSettings.coreAxis = (Lighting2D.CoreAxis)EditorGUILayout.EnumPopup("Core Axis", profile.commonSettings.coreAxis);

				profile.commonSettings.lightingResolution = EditorGUILayout.Slider("Lighting Resolution", profile.commonSettings.lightingResolution, 0.25f, 1.0f);

				profile.commonSettings.hdr = EditorGUILayout.Toggle("HDR", profile.commonSettings.hdr);

				profile.commonSettings.drawAdditiveLights = EditorGUILayout.Toggle("Additive Lights", profile.commonSettings.drawAdditiveLights);

				profile.commonSettings.drawPenumbra = EditorGUILayout.Toggle("Light Penumbra", profile.commonSettings.drawPenumbra);

				profile.commonSettings.drawSunPenumbra = EditorGUILayout.Toggle("Sun Penumbra", profile.commonSettings.drawSunPenumbra);

				profile.commonSettings.drawHighQualityShadows = EditorGUILayout.Toggle("High Quality Shadows", profile.commonSettings.drawHighQualityShadows);

				profile.commonSettings.drawRooms = EditorGUILayout.Toggle("Rooms", profile.commonSettings.drawRooms);

				profile.commonSettings.drawOcclusion = EditorGUILayout.Toggle("Ambient Occlusion", profile.commonSettings.drawOcclusion);

				profile.commonSettings.darknessBuffer = EditorGUILayout.Toggle("Darkness Buffer", profile.commonSettings.darknessBuffer);

				EditorGUI.indentLevel = EditorGUI.indentLevel - 1;
			}

			foldout_daylighting = EditorGUILayout.Foldout(foldout_daylighting, "Day" );

			if (foldout_daylighting) {
				EditorGUI.indentLevel = EditorGUI.indentLevel + 1;	

				profile.dayLightingSettings.sunDirection = EditorGUILayout.FloatField("Sun Rotation", profile.dayLightingSettings.sunDirection);

				float sunPenumbra = EditorGUILayout.FloatField("Sun Penumbra", profile.dayLightingSettings.sunPenumbra);
				if (sunPenumbra < 0) {
					sunPenumbra = 0;
				}
				if (sunPenumbra != profile.dayLightingSettings.sunPenumbra) {
					profile.dayLightingSettings.sunPenumbra = sunPenumbra;
				}

				profile.dayLightingSettings.drawDayShadows = EditorGUILayout.Toggle("Cast Shadows", profile.dayLightingSettings.drawDayShadows);

				profile.dayLightingSettings.shadowDarkness = EditorGUILayout.Slider("Shadow Darkness", profile.dayLightingSettings.shadowDarkness, 0, 1);

				profile.dayLightingSettings.layerCount = EditorGUILayout.IntSlider ("Layer Count", profile.dayLightingSettings.layerCount, 1, 4);
			
				EditorGUI.indentLevel = EditorGUI.indentLevel - 1;
			}

			foldout_atlas = EditorGUILayout.Foldout(foldout_atlas, "Atlas" );

			if (foldout_atlas) {
				EditorGUI.indentLevel = EditorGUI.indentLevel + 1;

				profile.atlasSettings.lightingSpriteAtlas = EditorGUILayout.Toggle("Enable Atlas", profile.atlasSettings.lightingSpriteAtlas);
				
				profile.atlasSettings.spriteAtlasSize = (Lighting2D.SpriteAtlasSize)EditorGUILayout.EnumPopup("Atlas Size", profile.atlasSettings.spriteAtlasSize);
				
				profile.atlasSettings.spriteAtlasScale = (Lighting2D.SpriteAtlasScale)EditorGUILayout.EnumPopup("Sprites Scaling", profile.atlasSettings.spriteAtlasScale);
						
				profile.atlasSettings.spriteAtlasPreloadFoldersCount = EditorGUILayout.IntField("Folder Count", profile.atlasSettings.spriteAtlasPreloadFoldersCount);

				EditorGUI.indentLevel = EditorGUI.indentLevel + 1;
				for(int i = 0; i < profile.atlasSettings.spriteAtlasPreloadFoldersCount; i++) {
					if (profile.atlasSettings.spriteAtlasPreloadFolders.Length <= i) {
						System.Array.Resize(ref profile.atlasSettings.spriteAtlasPreloadFolders, i + 1);
					}
					profile.atlasSettings.spriteAtlasPreloadFolders[i] = EditorGUILayout.TextField("Folder (" + (i + 1) + ")", profile.atlasSettings.spriteAtlasPreloadFolders[i]);
				}
				
				EditorGUI.indentLevel = EditorGUI.indentLevel - 1;
				EditorGUI.indentLevel = EditorGUI.indentLevel - 1;
			}

			foldout_buffers = EditorGUILayout.Foldout(foldout_buffers, "Buffers" );

			if (foldout_buffers) {
				EditorGUI.indentLevel = EditorGUI.indentLevel + 1;

				profile.lightingSourceSettings.fixedLightBufferSize = EditorGUILayout.Toggle("Fixed Light Buffer", profile.lightingSourceSettings.fixedLightBufferSize);

				if (profile.lightingSourceSettings.fixedLightBufferSize) {
					profile.lightingSourceSettings.fixedLightTextureSize = (LightingSourceTextureSize)EditorGUILayout.EnumPopup("Fixed Light Buffer Size", profile.lightingSourceSettings.fixedLightTextureSize);
					profile.lightingSourceSettings.lightingBufferPreload = EditorGUILayout.Toggle("Pre Load Lights", profile.lightingSourceSettings.lightingBufferPreload);
					profile.lightingSourceSettings.lightingBufferPreloadCount = (int)EditorGUILayout.Slider("Pre Load Count", profile.lightingSourceSettings.lightingBufferPreloadCount, 1, 50);
				} else {
					EditorGUI.BeginDisabledGroup(true);
					EditorGUILayout.EnumPopup("Fixed Light Buffer Size", profile.lightingSourceSettings.fixedLightTextureSize);
					EditorGUILayout.Toggle("Pre Load Lights", profile.lightingSourceSettings.lightingBufferPreload);
					EditorGUILayout.Slider("Pre Load Count", profile.lightingSourceSettings.lightingBufferPreloadCount, 1, 50);
					EditorGUI.EndDisabledGroup();
				}

				EditorGUI.indentLevel = EditorGUI.indentLevel - 1;
			}
		
			profile.triangulation = (PolygonTriangulator2D.Triangulation)EditorGUILayout.EnumPopup("Triangulation", profile.triangulation);

			profile.disable = EditorGUILayout.Toggle("Disable", profile.disable);
		
			if (EditorGUI.EndChangeCheck ()) {
				LightingMainBuffer2D.ForceUpdate();	
				Lighting2D.UpdateByProfile(profile);
			}

			if (profile.renderingPipeline != Lighting2D.RenderingPipeline.Standard) {
				EditorGUI.EndDisabledGroup();
			}

			if (GUI.changed && EditorApplication.isPlaying == false) {
				EditorUtility.SetDirty(profile);

				if (mainProfile != null) {
					EditorUtility.SetDirty(mainProfile);
				}
			}
		} else {
			EditorGUILayout.HelpBox("Lighting2D Settings Profile Not Found!", MessageType.Error);
		}	
	}

	void Profiler() {
		EditorGUILayout.ObjectField("Atlas", SpriteAtlasManager.GetAtlasPage().GetTexture(), typeof(Texture2D), true);

		EditorGUILayout.HelpBox(SpriteAtlasManager.GetAtlasPage().spriteCount.ToString(), MessageType.Info);
		EditorGUILayout.HelpBox("Normal Sprites " + SpriteAtlasManager.dictionaries.GetList(SpriteAtlasRequest.Type.Normal).Count, MessageType.Info);
		EditorGUILayout.HelpBox("White Sprites " + SpriteAtlasManager.dictionaries.GetList(SpriteAtlasRequest.Type.WhiteMask), MessageType.Info);
		EditorGUILayout.HelpBox("Black Sprites " + SpriteAtlasManager.dictionaries.GetList(SpriteAtlasRequest.Type.BlackMask), MessageType.Info);
	}
}