﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DayLighting2D {
	static Color color = new Color();
	static LightingManager2D manager;
	static Material material;

    public static void Draw(Camera camera, Vector2D offset, float z) {
		//DayLightingCollider.Shadow(camera, offset, z);

		//DayLightingTilemap.Shadow(camera, offset, z);

		//DayLightingCollider.Mask(camera, offset, z);

		for(int i = 0; i < Lighting2D.dayLightingSettings.layerCount; i++) {
			DayLightingBufferCollider.Shadow(camera, offset, z, i);

			DayLightingBufferCollider.ShadowSprites(camera, offset, z, i);

			DayLightingBufferCollider.WithoutAtlas.Mask(camera, offset, z, i);
		}
		
		ShadowDarkness(camera, z);
	}

	static void ShadowDarkness(Camera camera, float z) {
		manager = LightingManager2D.Get();

		color.a = 1f - Lighting2D.dayLightingSettings.shadowDarkness;

		if (color.a > 0.01f) {
			color.r = 0.5f;
			color.g = 0.5f;
			color.b = 0.5f;
				
			material = Lighting2D.materials.GetAdditive();
			material.mainTexture = null;		
			material.SetColor ("_TintColor", color);

			Lighting2DUtility.Max2D.DrawImage(material, Vector2.zero, Lighting2DRender.GetSize(camera), 0, z);
		}
	}
}

