Attribute VB_Name = "Protocol"

'
Option Explicit

''
'When we have a list of strings, we use this to separate them and prevent
'having too many string lengths in the queue. Yes, each string is NULL-terminated :P
Public Const SEPARATOR             As String * 1 = vbNullChar

Public Enum ServerPacketID

    connected
    logged                  ' LOGGED  0
    RemoveDialogs           ' QTDL
    RemoveCharDialog        ' QDL
    NavigateToggle          ' NAVEG
    EquiteToggle
    Disconnect              ' FINOK
    CommerceEnd             ' FINCOMOK
    BankEnd                 ' FINBANOK
    CommerceInit            ' INITCOM
    BankInit                ' INITBANCO
    UserCommerceInit        ' INITCOMUSU   10
    UserCommerceEnd         ' FINCOMUSUOK
    ShowBlacksmithForm      ' SFH
    ShowCarpenterForm       ' SFC
    NPCKillUser             ' 6
    BlockedWithShieldUser   ' 7
    BlockedWithShieldOther  ' 8
    CharSwing               ' U1
    SafeModeOn              ' SEGON
    SafeModeOff             ' SEGOFF 20
    PartySafeOn
    PartySafeOff
    CantUseWhileMeditating  ' M!
    UpdateSta               ' ASS
    UpdateMana              ' ASM
    UpdateHP                ' ASH
    UpdateGold              ' ASG
    UpdateExp               ' ASE 30
    changeMap               ' CM
    PosUpdate               ' PU
    NPCHitUser              ' N2
    UserHitNPC              ' U2
    UserAttackedSwing       ' U3
    UserHittedByUser        ' N4
    UserHittedUser          ' N5
    ChatOverHead            ' ||
    ConsoleMsg              ' || - Beware!! its the same as above, but it was properly splitted
    GuildChat               ' |+   40
    ShowMessageBox          ' !!
    MostrarCuenta
    CharacterCreate         ' CC
    CharacterRemove         ' BP
    CharacterMove           ' MP, +, * and _ '
    UserIndexInServer       ' IU
    UserCharIndexInServer   ' IP
    ForceCharMove
    CharacterChange         ' CP
    ObjectCreate            ' HO
    fxpiso
    ObjectDelete            ' BO  50
    BlockPosition           ' BQ
    PlayMIDI                ' TM
    PlayWave                ' TW
    guildList               ' GL
    AreaChanged             ' CA
    PauseToggle             ' BKW
    RainToggle              ' LLU
    CreateFX                ' CFX
    UpdateUserStats         ' EST
    WorkRequestTarget       ' T01 60
    ChangeInventorySlot     ' CSI
    InventoryUnlockSlots
    ChangeBankSlot          ' SBO
    ChangeSpellSlot         ' SHS
    Atributes               ' ATR
    BlacksmithWeapons       ' LAH
    BlacksmithArmors        ' LAR
    CarpenterObjects        ' OBR
    RestOK                  ' DOK
    ErrorMsg                ' ERR
    Blind                   ' CEGU 70
    Dumb                    ' DUMB
    ShowSignal              ' MCAR
    ChangeNPCInventorySlot  ' NPCI
    UpdateHungerAndThirst   ' EHYS
    MiniStats               ' MEST
    LevelUp                 ' SUNI
    AddForumMsg             ' FMSG
    ShowForumForm           ' MFOR
    SetInvisible            ' NOVER 80
    MeditateToggle          ' MEDOK
    BlindNoMore             ' NSEGUE
    DumbNoMore              ' NESTUP
    SendSkills              ' SKILLS
    TrainerCreatureList     ' LSTCRI
    guildNews               ' GUILDNE
    OfferDetails            ' PEACEDE & ALLIEDE
    AlianceProposalsList    ' ALLIEPR
    PeaceProposalsList      ' PEACEPR 90
    CharacterInfo           ' CHRINFO
    GuildLeaderInfo         ' LEADERI
    GuildDetails            ' CLANDET
    ShowGuildFundationForm  ' SHOWFUN
    ParalizeOK              ' PARADOK
    ShowUserRequest         ' PETICIO
    ChangeUserTradeSlot     ' COMUSUINV
    'SendNight              ' NOC
    Pong
    UpdateTagAndStatus
    FYA
    CerrarleCliente
    Contadores
    ShowPapiro              ' SWP
    
    'GM messages
    SpawnListt               ' SPL
    ShowSOSForm             ' MSOS
    ShowMOTDEditionForm     ' ZMOTD
    ShowGMPanelForm         ' ABPANEL
    UserNameList            ' LISTUSU
    UserOnline '110
    ParticleFX
    ParticleFXToFloor
    ParticleFXWithDestino
    ParticleFXWithDestinoXY
    Hora
    light
    AuraToChar
    SpeedToChar
    LightToFloor
    NieveToggle
    NieblaToggle
    Goliath
    TextOverChar
    TextOverTile
    TextCharDrop
    FlashScreen
    AlquimistaObj
    ShowAlquimiaForm
    SastreObj
    ShowSastreForm ' 126
    VelocidadToggle
    MacroTrabajoToggle
    BindKeys
    ShowFrmLogear
    ShowFrmMapa
    InmovilizadoOK
    BarFx
    LocaleMsg
    ShowPregunta
    DatosGrupo
    ubicacion
    ArmaMov
    EscudoMov
    ViajarForm
    NadarToggle
    ShowFundarClanForm
    CharUpdateHP
    CharUpdateMAN
    PosLLamadaDeClan
    QuestDetails
    QuestListSend
    NpcQuestListSend
    UpdateNPCSimbolo
    ClanSeguro
    Intervals
    UpdateUserKey
    UpdateRM
    UpdateDM
    SeguroResu
    Stopped
    InvasionInfo
    CommerceRecieveChatMessage
    DoAnimation
    OpenCrafting
    CraftingItem
    CraftingCatalyst
    CraftingResult
    ForceUpdate
    GuardNotice
    AnswerReset
    ObjQuestListSend
    UpdateBankGld
    PelearConPezEspecial
    Privilegios
    
    AccountCharacterList
    
    [PacketCount]
End Enum

Public Enum ClientPacketID

    LoginExistingChar       'OLOGIN
    LoginNewChar            'NLOGIN
    Talk                    ';
    Yell                    '-
    Whisper                 '\
    Walk                    'M
    RequestPositionUpdate   'RPU
    Attack                  'AT
    PickUp                  'AG
    SafeToggle              '/SEG & SEG  (SEG's behaviour has to be coded in the client)
    PartySafeToggle
    RequestGuildLeaderInfo  'GLINFO
    RequestAtributes        'ATR
    RequestSkills           'ESKI
    RequestMiniStats        'FEST
    CommerceEnd             'FINCOM
    UserCommerceEnd         'FINCOMUSU
    BankEnd                 'FINBAN
    UserCommerceOk          'COMUSUOK
    UserCommerceReject      'COMUSUNO
    Drop                    'TI
    CastSpell               'LH
    LeftClick               'LC
    DoubleClick             'RC
    Work                    'UK
    UseSpellMacro           'UMH
    UseItem                 'USA
    CraftBlacksmith         'CNS
    CraftCarpenter          'CNC
    WorkLeftClick           'WLC
    CreateNewGuild          'CIG
    SpellInfo               'INFS
    EquipItem               'EQUI
    Change_Heading           'CHEA
    ModifySkills            'SKSE
    Train                   'ENTR
    CommerceBuy             'COMP
    BankExtractItem         'RETI
    CommerceSell            'VEND
    BankDeposit             'DEPO
    ForumPost               'DEMSG
    MoveSpell               'DESPHE
    ClanCodexUpdate         'DESCOD
    UserCommerceOffer       'OFRECER
    GuildAcceptPeace        'ACEPPEAT
    GuildRejectAlliance     'RECPALIA
    GuildRejectPeace        'RECPPEAT
    GuildAcceptAlliance     'ACEPALIA
    GuildOfferPeace         'PEACEOFF
    GuildOfferAlliance      'ALLIEOFF
    GuildAllianceDetails    'ALLIEDET
    GuildPeaceDetails       'PEACEDET
    GuildRequestJoinerInfo  'ENVCOMEN
    GuildAlliancePropList   'ENVALPRO
    GuildPeacePropList      'ENVPROPP
    GuildDeclareWar         'DECGUERR
    GuildNewWebsite         'NEWWEBSI
    GuildAcceptNewMember    'ACEPTARI
    GuildRejectNewMember    'RECHAZAR
    GuildKickMember         'ECHARCLA
    GuildUpdateNews         'ACTGNEWS
    GuildMemberInfo         '1HRINFO<
    GuildOpenElections      'ABREELEC
    GuildRequestMembership  'SOLICITUD
    GuildRequestDetails     'CLANDETAILS
    Online                  '/ONLINE
    Quit                    '/SALIR
    GuildLeave              '/SALIRCLAN
    RequestAccountState     '/BALANCE
    PetStand                '/QUIETO
    PetFollow               '/ACOMPA�AR
    PetLeave                '/LIBERAR
    GrupoMsg                '/GrupoMsg
    TrainList               '/ENTRENAR
    Rest                    '/DESCANSAR
    Meditate                '/MEDITAR
    Resucitate              '/RESUCITAR
    Heal                    '/CURAR
    Help                    '/AYUDA
    RequestStats            '/EST
    CommerceStart           '/COMERCIAR
    BankStart               '/BOVEDA
    Enlist                  '/ENLISTAR
    Information             '/INFORMACION
    Reward                  '/RECOMPENSA
    RequestMOTD             '/MOTD
    UpTime                  '/UPTIME
    GuildMessage            '/CMSG
    CentinelReport          '/CENTINELA
    GuildOnline             '/ONLINECLAN
    CouncilMessage          '/BMSG
    RoleMasterRequest       '/ROL
    ChangeDescription       '/DESC
    GuildVote               '/VOTO
    punishments             '/PENAS
    Gamble                  '/APOSTAR
    LeaveFaction            '/RETIRAR ( with no arguments )
    BankExtractGold         '/RETIRAR ( with arguments )
    BankDepositGold         '/DEPOSITAR
    Denounce                '/DENUNCIAR
    Ping                    '/PING
    
    'GM messages
    GMMessage               '/GMSG
    showName                '/SHOWNAME
    OnlineRoyalArmy         '/ONLINEREAL
    OnlineChaosLegion       '/ONLINECAOS
    GoNearby                '/IRCERCA
    comment                 '/REM
    serverTime              '/HORA
    Where                   '/DONDE
    CreaturesInMap          '/NENE
    WarpMeToTarget          '/TELEPLOC
    WarpChar                '/TELEP
    Silence                 '/SILENCIAR
    SOSShowList             '/SHOW SOS
    SOSRemove               'SOSDONE
    GoToChar                '/IRA
    invisible               '/INVISIBLE
    GMPanel                 '/PANELGM
    RequestUserList         'LISTUSU
    Working                 '/TRABAJANDO
    Hiding                  '/OCULTANDO
    Jail                    '/CARCEL
    KillNPC                 '/RMATA
    WarnUser                '/ADVERTENCIA
    EditChar                '/MOD
    RequestCharInfo         '/INFO
    RequestCharStats        '/STAT
    RequestCharGold         '/BAL
    RequestCharInventory    '/INV
    RequestCharBank         '/BOV
    RequestCharSkills       '/SKILLS
    ReviveChar              '/REVIVIR
    OnlineGM                '/ONLINEGM
    OnlineMap               '/ONLINEMAP
    Forgive                 '/PERDON
    Kick                    '/ECHAR
    ExecuteCmd              '/EJECUTAR
    BanChar                 '/BAN
    UnbanChar               '/UNBAN
    NPCFollow               '/SEGUIR
    SummonChar              '/SUM
    SpawnListRequest        '/CC
    SpawnCreature           'SPA
    ResetNPCInventory       '/RESETINV
    CleanWorld              '/LIMPIAR
    ServerMessage           '/RMSG
    NickToIP                '/NICK2IP
    IPToNick                '/IP2NICK
    GuildOnlineMembers      '/ONCLAN
    TeleportCreate          '/CT
    TeleportDestroy         '/DT
    RainToggle              '/LLUVIA
    SetCharDescription      '/SETDESC
    ForceMIDIToMap          '/FORCEMIDIMAP
    ForceWAVEToMap          '/FORCEWAVMAP
    RoyalArmyMessage        '/REALMSG
    ChaosLegionMessage      '/CAOSMSG
    CitizenMessage          '/CIUMSG
    CriminalMessage         '/CRIMSG
    TalkAsNPC               '/TALKAS
    DestroyAllItemsInArea   '/MASSDEST
    AcceptRoyalCouncilMember '/ACEPTCONSE
    AcceptChaosCouncilMember '/ACEPTCONSECAOS
    ItemsInTheFloor         '/PISO
    MakeDumb                '/ESTUPIDO
    MakeDumbNoMore          '/NOESTUPIDO
    CouncilKick             '/KICKCONSE
    SetTrigger              '/TRIGGER
    AskTrigger              '/TRIGGER with no args
    BannedIPList            '/BANIPLIST
    BannedIPReload          '/BANIPRELOAD
    GuildMemberList         '/MIEMBROSCLAN
    GuildBan                '/BANCLAN
    banip                   '/BANIP
    UnBanIp                 '/UNBANIP
    CreateItem              '/CI
    DestroyItems            '/DEST
    ChaosLegionKick         '/NOCAOS
    RoyalArmyKick           '/NOREAL
    ForceMIDIAll            '/FORCEMIDI
    ForceWAVEAll            '/FORCEWAV
    RemovePunishment        '/BORRARPENA
    Tile_BlockedToggle       '/BLOQ
    KillNPCNoRespawn        '/MATA
    KillAllNearbyNPCs       '/MASSKILL
    LastIP                  '/LASTIP
    ChangeMOTD              '/MOTDCAMBIA
    SetMOTD                 'ZMOTD
    SystemMessage           '/SMSG
    CreateNPC               '/ACC
    CreateNPCWithRespawn    '/RACC
    ImperialArmour          '/AI1 - 4
    ChaosArmour             '/AC1 - 4
    NavigateToggle          '/NAVE
    ServerOpenToUsersToggle '/HABILITAR
    Participar              '/APAGAR
    TurnCriminal            '/CONDEN
    ResetFactions           '/RAJAR
    RemoveCharFromGuild     '/RAJARCLAN
    AlterName               '/ANAME
    DoBackUpCmd             '/DOBACKUP
    ShowGuildMessages       '/SHOWCMSG
    ChangeMapInfoPK         '/MODMAPINFO PK
    ChangeMapInfoBackup     '/MODMAPINFO BACKUP
    ChangeMapInfoRestricted '/MODMAPINFO RESTRINGIR
    ChangeMapInfoNoMagic    '/MODMAPINFO MAGIASINEFECTO
    ChangeMapInfoNoInvi     '/MODMAPINFO INVISINEFECTO
    ChangeMapInfoNoResu     '/MODMAPINFO RESUSINEFECTO
    ChangeMapInfoLand       '/MODMAPINFO TERRENO
    ChangeMapInfoZone       '/MODMAPINFO ZONA
    SaveChars               '/GRABAR
    CleanSOS                '/BORRAR SOS
    ShowServerForm          '/SHOW INT
    night                   '/NOCHE
    KickAllChars            '/ECHARTODOSPJS
    ReloadNPCs              '/RELOADNPCS
    ReloadServerIni         '/RELOADSINI
    ReloadSpells            '/RELOADHECHIZOS
    ReloadObjects           '/RELOADOBJ
    ChatColor               '/CHATCOLOR
    Ignored                 '/IGNORADO
    CheckSlot               '/SLOT
    
    'Nuevas Ladder
    SetSpeed
    GlobalMessage           '/CONSOLA
    GlobalOnOff
    UseKey
    DayCmd
    SetTime
    DonateGold              '/DONAR
    Promedio                '/PROMEDIO
    GiveItem                '/DAR
    OfertaInicial
    OfertaDeSubasta
    QuestionGM
    CuentaRegresiva
    PossUser
    Duel
    AcceptDuel
    CancelDuel
    QuitDuel
    NieveToggle
    NieblaToggle
    TransFerGold
    Moveitem
    Genio
    Casarse
    CraftAlquimista
    FlagTrabajar
    CraftSastre
    MensajeUser
    TraerBoveda
    CompletarAccion
    InvitarGrupo
    ResponderPregunta
    RequestGrupo
    AbandonarGrupo
    HecharDeGrupo
    MacroPossent
    SubastaInfo
    BanCuenta
    UnbanCuenta
    CerrarCliente
    EventoInfo
    CrearEvento
    BanTemporal
    CancelarExit
    CrearTorneo
    ComenzarTorneo
    CancelarTorneo
    BusquedaTesoro
    CompletarViaje
    BovedaMoveItem
    QuieroFundarClan
    llamadadeclan
    MarcaDeClanPack
    MarcaDeGMPack
    Quest
    QuestAccept
    QuestListRequest
    QuestDetailsRequest
    QuestAbandon
    SeguroClan
    home                    '/HOGAR
    Consulta                '/CONSULTA
    GetMapInfo              '/MAPINFO
    FinEvento
    SeguroResu
    CuentaExtractItem
    CuentaDeposit
    CreateEvent
    CommerceSendChatMessage
    LogMacroClickHechizo
    AddItemCrafting
    RemoveItemCrafting
    AddCatalyst
    RemoveCatalyst
    CraftItem
    CloseCrafting
    MoveCraftItem
    PetLeaveAll
    ResetChar               '/RESET NICK
    resetearPersonaje
    DeleteItem
    FinalizarPescaEspecial
    RomperCania
    UseItemU
    RepeatMacro
    
    CreateAccount
    LoginAccount
    DeleteCharacter
    
    [PacketCount]
End Enum

Public Enum e_EditOptions

    eo_Gold = 1
    eo_Experience
    eo_Body
    eo_Head
    eo_CiticensKilled
    eo_CriminalsKilled
    eo_Level
    eo_Class
    eo_Skills
    eo_SkillPointsLeft
    eo_Sex
    eo_Raza
    eo_Arma
    eo_Escudo
    eo_CASCO
    eo_Particula
    eo_Vida
    eo_Mana
    eo_Energia
    eo_MinHP
    eo_MinMP
    eo_Hit
    eo_MinHit
    eo_MaxHit
    eo_Desc
    eo_Intervalo
    eo_Hogar

End Enum

Public Enum e_FontTypeNames

    FONTTYPE_TALK
    FONTTYPE_FIGHT
    FONTTYPE_WARNING
    FONTTYPE_INFO
    FONTTYPE_INFOBOLD
    FONTTYPE_EJECUCION
    FONTTYPE_PARTY
    FONTTYPE_VENENO
    FONTTYPE_GUILD
    FONTTYPE_SERVER
    FONTTYPE_GUILDMSG
    FONTTYPE_CONSEJO
    FONTTYPE_CONSEJOCAOS
    FONTTYPE_CONSEJOVesA
    FONTTYPE_CONSEJOCAOSVesA
    FONTTYPE_CENTINELA
    FONTTYPE_GMMSG
    FONTTYPE_GM
    FONTTYPE_DIOS
    FONTTYPE_CITIZEN
    FONTTYPE_CRIMINAL
    FONTTYPE_EXP
    FONTTYPE_SUBASTA
    FONTTYPE_GLOBAL
    FONTTYPE_MP
    FONTTYPE_ROSA
    FONTTYPE_VIOLETA
    FONTTYPE_INFOIAO
    
    FONTTYPE_New_Amarillo_Oscuro
    FONTTYPE_New_Verde_Oscuro
    FONTTYPE_New_Naranja
    FONTTYPE_New_Celeste
    FONTTYPE_New_Amarillo_Verdoso
    FONTTYPE_New_Gris
    FONTTYPE_New_Blanco
    FONTTYPE_New_Rojo_Salmon
    FONTTYPE_New_DONADOR
    FONTTYPE_New_GRUPO
    FONTTYPE_New_Eventos
    
    FONTTYPE_PROMEDIO_IGUAL
    FONTTYPE_PROMEDIO_MENOR
    FONTTYPE_PROMEDIO_MAYOR
    
End Enum

Public Type t_PersonajeCuenta

    nombre As String
    nivel As Byte
    Mapa As Integer
    posX As Integer
    posY As Integer
    cuerpo As Integer
    Cabeza As Integer
    Status As Byte
    clase As Byte
    Arma As Integer
    Escudo As Integer
    Casco As Integer
    ClanIndex As Integer

End Type

Private Reader  As Network.Reader

Public Sub InitializePacketList()
    Call Protocol_Writes.InitializeAuxiliaryBuffer
End Sub

''
' Handles incoming data.
'
' @param    UserIndex The index of the user sending the message.

Public Function HandleIncomingData(ByVal userindex As Integer, ByVal Message As Network.Reader) As Boolean

On Error Resume Next
    Set Reader = Message
    
    Dim PacketId As Long
    PacketId = Reader.ReadInt
    
#If STRESSER = 1 Then
    Debug.Print "Paquete: " & PacketId
#End If

    
    Dim actual_time As Long
    
    actual_time = GetTickCount()
    
    
    If actual_time - UserList(userindex).Counters.TimeLastReset >= 5000 Then
        UserList(userindex).Counters.TimeLastReset = actual_time
        UserList(userindex).Counters.PacketCount = 0
    End If
    
    UserList(userindex).Counters.PacketCount = UserList(userindex).Counters.PacketCount + 1
    
    If UserList(userindex).Counters.PacketCount > 100 Then
        'Lo kickeo
        Call SendData(SendTarget.ToAdmins, userindex, PrepareMessageConsoleMsg("Control de paquetes -> El usuario " & UserList(userindex).name & " | Iteraci�n paquetes | �ltimo paquete: " & PacketId & ".", e_FontTypeNames.FONTTYPE_FIGHT))
        UserList(userindex).Counters.PacketCount = 0
        'Call CloseSocket(userindex)
        Exit Function
    End If

    If PacketId < 0 Or PacketId >= ClientPacketID.PacketCount Then
        Call LogEdicionPaquete("El usuario " & UserList(userindex).IP & " mando fake paquet " & PacketId)
        If IP_Blacklist.Exists(UserList(userindex).IP) = 0 Then
            Call IP_Blacklist.Add(UserList(userindex).IP, "FAKE")
        End If
        Call SendData(SendTarget.ToGM, userindex, PrepareMessageConsoleMsg("EL USUARIO " & UserList(userindex).name & " | IP: " & UserList(userindex).IP & " EST� ENVIANDO PAQUETES INV�LIDOS", e_FontTypeNames.FONTTYPE_GUILD))
        Call CloseSocket(userindex)
        Exit Function
    End If
    
    'Does the packet requires a logged account??
    If Not (PacketId = ClientPacketID.CreateAccount Or _
            PacketId = ClientPacketID.LoginAccount) Then
               
        'Is the account actually logged?
        If UserList(userindex).AccountID = 0 Then
            Call CloseSocket(userindex)
            Exit Function
        End If
        
        If Not (PacketId = ClientPacketID.LoginExistingChar Or PacketId = ClientPacketID.LoginNewChar) Then
                   
            'Is the user actually logged?
            If Not UserList(userindex).flags.UserLogged Then
                Call CloseSocket(userindex)
                Exit Function
            
            'He is logged. Reset idle counter if id is valid.
            ElseIf PacketId <= ClientPacketID.[PacketCount] Then
                UserList(userindex).Counters.IdleCount = 0
            End If
        ElseIf PacketId <= ClientPacketID.[PacketCount] Then
            UserList(userindex).Counters.IdleCount = 0
        End If
    End If
        
    Select Case PacketId
        Case ClientPacketID.LoginExistingChar
            Call HandleLoginExistingChar(userindex)
        Case ClientPacketID.LoginNewChar
            Call HandleLoginNewChar(userindex)
        Case ClientPacketID.Walk
            Call HandleWalk(userindex)
        Case ClientPacketID.Attack
            Call HandleAttack(userindex)
        Case ClientPacketID.Talk
            Call HandleTalk(userindex)
        Case ClientPacketID.Yell
            Call HandleYell(userindex)
        Case ClientPacketID.Whisper
            Call HandleWhisper(userindex)
        Case ClientPacketID.RequestPositionUpdate
            Call HandleRequestPositionUpdate(userindex)
        Case ClientPacketID.PickUp
            Call HandlePickUp(userindex)
        Case ClientPacketID.SafeToggle
            Call HandleSafeToggle(userindex)
        Case ClientPacketID.PartySafeToggle
            Call HandlePartyToggle(userindex)
        Case ClientPacketID.RequestGuildLeaderInfo
            Call HandleRequestGuildLeaderInfo(userindex)
        Case ClientPacketID.RequestAtributes
            Call HandleRequestAtributes(userindex)
        Case ClientPacketID.RequestSkills
            Call HandleRequestSkills(userindex)
        Case ClientPacketID.RequestMiniStats
            Call HandleRequestMiniStats(userindex)
        Case ClientPacketID.CommerceEnd
            Call HandleCommerceEnd(userindex)
        Case ClientPacketID.UserCommerceEnd
            Call HandleUserCommerceEnd(userindex)
        Case ClientPacketID.BankEnd
            Call HandleBankEnd(userindex)
        Case ClientPacketID.UserCommerceOk
            Call HandleUserCommerceOk(userindex)
        Case ClientPacketID.UserCommerceReject
            Call HandleUserCommerceReject(userindex)
        Case ClientPacketID.Drop
            Call HandleDrop(userindex)
        Case ClientPacketID.CastSpell
            Call HandleCastSpell(userindex) ', crc)
        Case ClientPacketID.LeftClick
            Call HandleLeftClick(userindex)
        Case ClientPacketID.DoubleClick
            Call HandleDoubleClick(userindex)
        Case ClientPacketID.Work
            Call HandleWork(userindex)
        Case ClientPacketID.UseSpellMacro
            Call HandleUseSpellMacro(userindex)
        Case ClientPacketID.UseItem
            Call HandleUseItem(userindex)
        Case ClientPacketID.UseItemU
            Call HandleUseItemU(userindex)
        Case ClientPacketID.CraftBlacksmith
            Call HandleCraftBlacksmith(userindex)
        Case ClientPacketID.CraftCarpenter
            Call HandleCraftCarpenter(userindex)
        Case ClientPacketID.WorkLeftClick
            Call HandleWorkLeftClick(userindex)
        Case ClientPacketID.CreateNewGuild
            Call HandleCreateNewGuild(userindex)
        Case ClientPacketID.SpellInfo
            Call HandleSpellInfo(userindex)
        Case ClientPacketID.EquipItem
            Call HandleEquipItem(userindex)
        Case ClientPacketID.Change_Heading
            Call HandleChange_Heading(userindex)
        Case ClientPacketID.ModifySkills
            Call HandleModifySkills(userindex)
        Case ClientPacketID.Train
            Call HandleTrain(userindex)
        Case ClientPacketID.CommerceBuy
            Call HandleCommerceBuy(userindex)
        Case ClientPacketID.BankExtractItem
            Call HandleBankExtractItem(userindex)
        Case ClientPacketID.CommerceSell
            Call HandleCommerceSell(userindex)
        Case ClientPacketID.BankDeposit
            Call HandleBankDeposit(userindex)
        Case ClientPacketID.ForumPost
            Call HandleForumPost(userindex)
        Case ClientPacketID.MoveSpell
            Call HandleMoveSpell(userindex)
        Case ClientPacketID.ClanCodexUpdate
            Call HandleClanCodexUpdate(userindex)
        Case ClientPacketID.UserCommerceOffer
            Call HandleUserCommerceOffer(userindex)
        Case ClientPacketID.GuildAcceptPeace
            Call HandleGuildAcceptPeace(userindex)
        Case ClientPacketID.GuildRejectAlliance
            Call HandleGuildRejectAlliance(userindex)
        Case ClientPacketID.GuildRejectPeace
            Call HandleGuildRejectPeace(userindex)
        Case ClientPacketID.GuildAcceptAlliance
            Call HandleGuildAcceptAlliance(userindex)
        Case ClientPacketID.GuildOfferPeace
            Call HandleGuildOfferPeace(userindex)
        Case ClientPacketID.GuildOfferAlliance
            Call HandleGuildOfferAlliance(userindex)
        Case ClientPacketID.GuildAllianceDetails
            Call HandleGuildAllianceDetails(userindex)
        Case ClientPacketID.GuildPeaceDetails
            Call HandleGuildPeaceDetails(userindex)
        Case ClientPacketID.GuildRequestJoinerInfo
            Call HandleGuildRequestJoinerInfo(userindex)
        Case ClientPacketID.GuildAlliancePropList
            Call HandleGuildAlliancePropList(userindex)
        Case ClientPacketID.GuildPeacePropList
            Call HandleGuildPeacePropList(userindex)
        Case ClientPacketID.GuildDeclareWar
            Call HandleGuildDeclareWar(userindex)
        Case ClientPacketID.GuildNewWebsite
            Call HandleGuildNewWebsite(userindex)
        Case ClientPacketID.GuildAcceptNewMember
            Call HandleGuildAcceptNewMember(userindex)
        Case ClientPacketID.GuildRejectNewMember
            Call HandleGuildRejectNewMember(userindex)
        Case ClientPacketID.GuildKickMember
            Call HandleGuildKickMember(userindex)
        Case ClientPacketID.GuildUpdateNews
            Call HandleGuildUpdateNews(userindex)
        Case ClientPacketID.GuildMemberInfo
            Call HandleGuildMemberInfo(userindex)
        Case ClientPacketID.GuildOpenElections
            Call HandleGuildOpenElections(userindex)
        Case ClientPacketID.GuildRequestMembership
            Call HandleGuildRequestMembership(userindex)
        Case ClientPacketID.GuildRequestDetails
            Call HandleGuildRequestDetails(userindex)
        Case ClientPacketID.Online
            Call HandleOnline(userindex)
        Case ClientPacketID.Quit
            Call HandleQuit(userindex)
        Case ClientPacketID.GuildLeave
            Call HandleGuildLeave(userindex)
        Case ClientPacketID.RequestAccountState
            Call HandleRequestAccountState(userindex)
        Case ClientPacketID.PetStand
            Call HandlePetStand(userindex)
        Case ClientPacketID.PetFollow
            Call HandlePetFollow(userindex)
        Case ClientPacketID.PetLeave
            Call HandlePetLeave(userindex)
        Case ClientPacketID.GrupoMsg
            Call HandleGrupoMsg(userindex)
        Case ClientPacketID.TrainList
            Call HandleTrainList(userindex)
        Case ClientPacketID.Rest
            Call HandleRest(userindex)
        Case ClientPacketID.Meditate
            Call HandleMeditate(userindex)
        Case ClientPacketID.Resucitate
            Call HandleResucitate(userindex)
        Case ClientPacketID.Heal
            Call HandleHeal(userindex)
        Case ClientPacketID.Help
            Call HandleHelp(userindex)
        Case ClientPacketID.RequestStats
            Call HandleRequestStats(userindex)
        Case ClientPacketID.CommerceStart
            Call HandleCommerceStart(userindex)
        Case ClientPacketID.BankStart
            Call HandleBankStart(userindex)
        Case ClientPacketID.Enlist
            Call HandleEnlist(userindex)
        Case ClientPacketID.Information
            Call HandleInformation(userindex)
        Case ClientPacketID.Reward
            Call HandleReward(userindex)
        Case ClientPacketID.RequestMOTD
            Call HandleRequestMOTD(userindex)
        Case ClientPacketID.UpTime
            Call HandleUpTime(userindex)
        Case ClientPacketID.GuildMessage
            Call HandleGuildMessage(userindex)
        Case ClientPacketID.CentinelReport
            Call HandleCentinelReport(userindex)
        Case ClientPacketID.GuildOnline
            Call HandleGuildOnline(userindex)
        Case ClientPacketID.CouncilMessage
            Call HandleCouncilMessage(userindex)
        Case ClientPacketID.RoleMasterRequest
            Call HandleRoleMasterRequest(userindex)
        Case ClientPacketID.ChangeDescription
            Call HandleChangeDescription(userindex)
        Case ClientPacketID.GuildVote
            Call HandleGuildVote(userindex)
        Case ClientPacketID.punishments
            Call HandlePunishments(userindex)
        Case ClientPacketID.Gamble
            Call HandleGamble(userindex)
        Case ClientPacketID.LeaveFaction
            Call HandleLeaveFaction(userindex)
        Case ClientPacketID.BankExtractGold
            Call HandleBankExtractGold(userindex)
        Case ClientPacketID.BankDepositGold
            Call HandleBankDepositGold(userindex)
        Case ClientPacketID.Denounce
            Call HandleDenounce(userindex)
        Case ClientPacketID.Ping
            Call HandlePing(userindex)
        Case ClientPacketID.GMMessage
            Call HandleGMMessage(userindex)
        Case ClientPacketID.showName
            Call HandleShowName(userindex)
        Case ClientPacketID.OnlineRoyalArmy
            Call HandleOnlineRoyalArmy(userindex)
        Case ClientPacketID.OnlineChaosLegion
            Call HandleOnlineChaosLegion(userindex)
        Case ClientPacketID.GoNearby
            Call HandleGoNearby(userindex)
        Case ClientPacketID.comment
            Call HandleComment(userindex)
        Case ClientPacketID.serverTime
            Call HandleServerTime(userindex)
        Case ClientPacketID.Where
            Call HandleWhere(userindex)
        Case ClientPacketID.CreaturesInMap
            Call HandleCreaturesInMap(userindex)
        Case ClientPacketID.WarpMeToTarget
            Call HandleWarpMeToTarget(userindex)
        Case ClientPacketID.WarpChar
            Call HandleWarpChar(userindex)
        Case ClientPacketID.Silence
            Call HandleSilence(userindex)
        Case ClientPacketID.SOSShowList
            Call HandleSOSShowList(userindex)
        Case ClientPacketID.SOSRemove
            Call HandleSOSRemove(userindex)
        Case ClientPacketID.GoToChar
            Call HandleGoToChar(userindex)
        Case ClientPacketID.invisible
            Call HandleInvisible(userindex)
        Case ClientPacketID.GMPanel
            Call HandleGMPanel(userindex)
        Case ClientPacketID.RequestUserList
            Call HandleRequestUserList(userindex)
        Case ClientPacketID.Working
            Call HandleWorking(userindex)
        Case ClientPacketID.Hiding
            Call HandleHiding(userindex)
        Case ClientPacketID.Jail
            Call HandleJail(userindex)
        Case ClientPacketID.KillNPC
            Call HandleKillNPC(userindex)
        Case ClientPacketID.WarnUser
            Call HandleWarnUser(userindex)
        Case ClientPacketID.EditChar
            Call HandleEditChar(userindex)
        Case ClientPacketID.RequestCharInfo
            Call HandleRequestCharInfo(userindex)
        Case ClientPacketID.RequestCharStats
            Call HandleRequestCharStats(userindex)
        Case ClientPacketID.RequestCharGold
            Call HandleRequestCharGold(userindex)
        Case ClientPacketID.RequestCharInventory
            Call HandleRequestCharInventory(userindex)
        Case ClientPacketID.RequestCharBank
            Call HandleRequestCharBank(userindex)
        Case ClientPacketID.RequestCharSkills
            Call HandleRequestCharSkills(userindex)
        Case ClientPacketID.ReviveChar
            Call HandleReviveChar(userindex)
        Case ClientPacketID.OnlineGM
            Call HandleOnlineGM(userindex)
        Case ClientPacketID.OnlineMap
            Call HandleOnlineMap(userindex)
        Case ClientPacketID.Forgive
            Call HandleForgive(userindex)
        Case ClientPacketID.Kick
            Call HandleKick(userindex)
        Case ClientPacketID.ExecuteCmd
            Call HandleExecute(userindex)
        Case ClientPacketID.BanChar
            Call HandleBanChar(userindex)
        Case ClientPacketID.UnbanChar
            Call HandleUnbanChar(userindex)
        Case ClientPacketID.NPCFollow
            Call HandleNPCFollow(userindex)
        Case ClientPacketID.SummonChar
            Call HandleSummonChar(userindex)
        Case ClientPacketID.SpawnListRequest
            Call HandleSpawnListRequest(userindex)
        Case ClientPacketID.SpawnCreature
            Call HandleSpawnCreature(userindex)
        Case ClientPacketID.ResetNPCInventory
            Call HandleResetNPCInventory(userindex)
        Case ClientPacketID.CleanWorld
            Call HandleCleanWorld(userindex)
        Case ClientPacketID.ServerMessage
            Call HandleServerMessage(userindex)
        Case ClientPacketID.NickToIP
            Call HandleNickToIP(userindex)
        Case ClientPacketID.IPToNick
            Call HandleIPToNick(userindex)
        Case ClientPacketID.GuildOnlineMembers
            Call HandleGuildOnlineMembers(userindex)
        Case ClientPacketID.TeleportCreate
            Call HandleTeleportCreate(userindex)
        Case ClientPacketID.TeleportDestroy
            Call HandleTeleportDestroy(userindex)
        Case ClientPacketID.RainToggle
            Call HandleRainToggle(userindex)
        Case ClientPacketID.SetCharDescription
            Call HandleSetCharDescription(userindex)
        Case ClientPacketID.ForceMIDIToMap
            Call HanldeForceMIDIToMap(userindex)
        Case ClientPacketID.ForceWAVEToMap
            Call HandleForceWAVEToMap(userindex)
        Case ClientPacketID.RoyalArmyMessage
            Call HandleRoyalArmyMessage(userindex)
        Case ClientPacketID.ChaosLegionMessage
            Call HandleChaosLegionMessage(userindex)
        Case ClientPacketID.CitizenMessage
            Call HandleCitizenMessage(userindex)
        Case ClientPacketID.CriminalMessage
            Call HandleCriminalMessage(userindex)
        Case ClientPacketID.TalkAsNPC
            Call HandleTalkAsNPC(userindex)
        Case ClientPacketID.DestroyAllItemsInArea
            Call HandleDestroyAllItemsInArea(userindex)
        Case ClientPacketID.AcceptRoyalCouncilMember
            Call HandleAcceptRoyalCouncilMember(userindex)
        Case ClientPacketID.AcceptChaosCouncilMember
            Call HandleAcceptChaosCouncilMember(userindex)
        Case ClientPacketID.ItemsInTheFloor
            Call HandleItemsInTheFloor(userindex)
        Case ClientPacketID.MakeDumb
            Call HandleMakeDumb(userindex)
        Case ClientPacketID.MakeDumbNoMore
            Call HandleMakeDumbNoMore(userindex)
        Case ClientPacketID.CouncilKick
            Call HandleCouncilKick(userindex)
        Case ClientPacketID.SetTrigger
            Call HandleSetTrigger(userindex)
        Case ClientPacketID.AskTrigger
            Call HandleAskTrigger(userindex)
        Case ClientPacketID.BannedIPList
            Call HandleBannedIPList(userindex)
        Case ClientPacketID.BannedIPReload
            Call HandleBannedIPReload(userindex)
        Case ClientPacketID.GuildMemberList
            Call HandleGuildMemberList(userindex)
        Case ClientPacketID.GuildBan
            Call HandleGuildBan(userindex)
        Case ClientPacketID.banip
            Call HandleBanIP(userindex)
        Case ClientPacketID.UnBanIp
            Call HandleUnbanIP(userindex)
        Case ClientPacketID.CreateItem
            Call HandleCreateItem(userindex)
        Case ClientPacketID.DestroyItems
            Call HandleDestroyItems(userindex)
        Case ClientPacketID.ChaosLegionKick
            Call HandleChaosLegionKick(userindex)
        Case ClientPacketID.RoyalArmyKick
            Call HandleRoyalArmyKick(userindex)
        Case ClientPacketID.ForceMIDIAll
            Call HandleForceMIDIAll(userindex)
        Case ClientPacketID.ForceWAVEAll
            Call HandleForceWAVEAll(userindex)
        Case ClientPacketID.RemovePunishment
            Call HandleRemovePunishment(userindex)
        Case ClientPacketID.Tile_BlockedToggle
            Call HandleTile_BlockedToggle(userindex)
        Case ClientPacketID.KillNPCNoRespawn
            Call HandleKillNPCNoRespawn(userindex)
        Case ClientPacketID.KillAllNearbyNPCs
            Call HandleKillAllNearbyNPCs(userindex)
        Case ClientPacketID.LastIP
            Call HandleLastIP(userindex)
        Case ClientPacketID.ChangeMOTD
            Call HandleChangeMOTD(userindex)
        Case ClientPacketID.SetMOTD
            Call HandleSetMOTD(userindex)
        Case ClientPacketID.SystemMessage
            Call HandleSystemMessage(userindex)
        Case ClientPacketID.CreateNPC
            Call HandleCreateNPC(userindex)
        Case ClientPacketID.CreateNPCWithRespawn
            Call HandleCreateNPCWithRespawn(userindex)
        Case ClientPacketID.ImperialArmour
            Call HandleImperialArmour(userindex)
        Case ClientPacketID.ChaosArmour
            Call HandleChaosArmour(userindex)
        Case ClientPacketID.NavigateToggle
            Call HandleNavigateToggle(userindex)
        Case ClientPacketID.ServerOpenToUsersToggle
            Call HandleServerOpenToUsersToggle(userindex)
        Case ClientPacketID.Participar
            Call HandleParticipar(userindex)
        Case ClientPacketID.TurnCriminal
            Call HandleTurnCriminal(userindex)
        Case ClientPacketID.ResetFactions
            Call HandleResetFactions(userindex)
        Case ClientPacketID.RemoveCharFromGuild
            Call HandleRemoveCharFromGuild(userindex)
        Case ClientPacketID.AlterName
            Call HandleAlterName(userindex)
        Case ClientPacketID.DoBackUpCmd
            Call HandleDoBackUp(userindex)
        Case ClientPacketID.ShowGuildMessages
            Call HandleShowGuildMessages(userindex)
        Case ClientPacketID.ChangeMapInfoPK
            Call HandleChangeMapInfoPK(userindex)
        Case ClientPacketID.ChangeMapInfoBackup
            Call HandleChangeMapInfoBackup(userindex)
        Case ClientPacketID.ChangeMapInfoRestricted
            Call HandleChangeMapInfoRestricted(userindex)
        Case ClientPacketID.ChangeMapInfoNoMagic
            Call HandleChangeMapInfoNoMagic(userindex)
        Case ClientPacketID.ChangeMapInfoNoInvi
            Call HandleChangeMapInfoNoInvi(userindex)
        Case ClientPacketID.ChangeMapInfoNoResu
            Call HandleChangeMapInfoNoResu(userindex)
        Case ClientPacketID.ChangeMapInfoLand
            Call HandleChangeMapInfoLand(userindex)
        Case ClientPacketID.ChangeMapInfoZone
            Call HandleChangeMapInfoZone(userindex)
        Case ClientPacketID.SaveChars
            Call HandleSaveChars(userindex)
        Case ClientPacketID.CleanSOS
            Call HandleCleanSOS(userindex)
        Case ClientPacketID.ShowServerForm
            Call HandleShowServerForm(userindex)
        Case ClientPacketID.night
            Call HandleNight(userindex)
        Case ClientPacketID.KickAllChars
            Call HandleKickAllChars(userindex)
        Case ClientPacketID.ReloadNPCs
            Call HandleReloadNPCs(userindex)
        Case ClientPacketID.ReloadServerIni
            Call HandleReloadServerIni(userindex)
        Case ClientPacketID.ReloadSpells
            Call HandleReloadSpells(userindex)
        Case ClientPacketID.ReloadObjects
            Call HandleReloadObjects(userindex)
        Case ClientPacketID.ChatColor
            Call HandleChatColor(userindex)
        Case ClientPacketID.Ignored
            Call HandleIgnored(userindex)
        Case ClientPacketID.CheckSlot
            Call HandleCheckSlot(userindex)
        Case ClientPacketID.SetSpeed
            Call HandleSetSpeed(userindex)
        Case ClientPacketID.GlobalMessage
            Call HandleGlobalMessage(userindex)
        Case ClientPacketID.GlobalOnOff
            Call HandleGlobalOnOff(userindex)
        Case ClientPacketID.UseKey
            Call HandleUseKey(userindex)
        Case ClientPacketID.DayCmd
            Call HandleDay(userindex)
        Case ClientPacketID.SetTime
            Call HandleSetTime(userindex)
        Case ClientPacketID.DonateGold
            Call HandleDonateGold(userindex)
        Case ClientPacketID.Promedio
            Call HandlePromedio(userindex)
        Case ClientPacketID.GiveItem
            Call HandleGiveItem(userindex)
        Case ClientPacketID.OfertaInicial
            Call HandleOfertaInicial(userindex)
        Case ClientPacketID.OfertaDeSubasta
            Call HandleOfertaDeSubasta(userindex)
        Case ClientPacketID.QuestionGM
            Call HandleQuestionGM(userindex)
        Case ClientPacketID.CuentaRegresiva
            Call HandleCuentaRegresiva(userindex)
        Case ClientPacketID.PossUser
            Call HandlePossUser(userindex)
        Case ClientPacketID.Duel
            Call HandleDuel(userindex)
        Case ClientPacketID.AcceptDuel
            Call HandleAcceptDuel(userindex)
        Case ClientPacketID.CancelDuel
            Call HandleCancelDuel(userindex)
        Case ClientPacketID.QuitDuel
            Call HandleQuitDuel(userindex)
        Case ClientPacketID.NieveToggle
            Call HandleNieveToggle(userindex)
        Case ClientPacketID.NieblaToggle
            Call HandleNieblaToggle(userindex)
        Case ClientPacketID.TransFerGold
            Call HandleTransFerGold(userindex)
        Case ClientPacketID.Moveitem
            Call HandleMoveItem(userindex)
        Case ClientPacketID.Genio
            Call HandleGenio(userindex)
        Case ClientPacketID.Casarse
            Call HandleCasamiento(userindex)
        Case ClientPacketID.CraftAlquimista
            Call HandleCraftAlquimia(userindex)
        Case ClientPacketID.FlagTrabajar
            Call HandleFlagTrabajar(userindex)
        Case ClientPacketID.CraftSastre
            Call HandleCraftSastre(userindex)
        Case ClientPacketID.MensajeUser
            Call HandleMensajeUser(userindex)
        Case ClientPacketID.TraerBoveda
            Call HandleTraerBoveda(userindex)
        Case ClientPacketID.CompletarAccion
            Call HandleCompletarAccion(userindex)
        Case ClientPacketID.InvitarGrupo
            Call HandleInvitarGrupo(userindex)
        Case ClientPacketID.ResponderPregunta
            Call HandleResponderPregunta(userindex)
        Case ClientPacketID.RequestGrupo
            Call HandleRequestGrupo(userindex)
        Case ClientPacketID.AbandonarGrupo
            Call HandleAbandonarGrupo(userindex)
        Case ClientPacketID.HecharDeGrupo
            Call HandleHecharDeGrupo(userindex)
        Case ClientPacketID.MacroPossent
            Call HandleMacroPos(userindex)
        Case ClientPacketID.SubastaInfo
            Call HandleSubastaInfo(userindex)
        Case ClientPacketID.BanCuenta
            Call HandleBanCuenta(userindex)
        Case ClientPacketID.UnbanCuenta
            Call HandleUnBanCuenta(userindex)
        Case ClientPacketID.CerrarCliente
            Call HandleCerrarCliente(userindex)
        Case ClientPacketID.EventoInfo
            Call HandleEventoInfo(userindex)
        Case ClientPacketID.CrearEvento
            Call HandleCrearEvento(userindex)
        Case ClientPacketID.BanTemporal
            Call HandleBanTemporal(userindex)
        Case ClientPacketID.CancelarExit
            Call HandleCancelarExit(userindex)
        Case ClientPacketID.CrearTorneo
            Call HandleCrearTorneo(userindex)
        Case ClientPacketID.ComenzarTorneo
            Call HandleComenzarTorneo(userindex)
        Case ClientPacketID.CancelarTorneo
            Call HandleCancelarTorneo(userindex)
        Case ClientPacketID.BusquedaTesoro
            Call HandleBusquedaTesoro(userindex)
        Case ClientPacketID.CompletarViaje
            Call HandleCompletarViaje(userindex)
        Case ClientPacketID.BovedaMoveItem
            Call HandleBovedaMoveItem(userindex)
        Case ClientPacketID.QuieroFundarClan
            Call HandleQuieroFundarClan(userindex)
        Case ClientPacketID.llamadadeclan
            Call HandleLlamadadeClan(userindex)
        Case ClientPacketID.MarcaDeClanPack
            Call HandleMarcaDeClan(userindex)
        Case ClientPacketID.MarcaDeGMPack
            Call HandleMarcaDeGM(userindex)
        Case ClientPacketID.Quest
            Call HandleQuest(userindex)
        Case ClientPacketID.QuestAccept
            Call HandleQuestAccept(userindex)
        Case ClientPacketID.QuestListRequest
            Call HandleQuestListRequest(userindex)
        Case ClientPacketID.QuestDetailsRequest
            Call HandleQuestDetailsRequest(userindex)
        Case ClientPacketID.QuestAbandon
            Call HandleQuestAbandon(userindex)
        Case ClientPacketID.SeguroClan
            Call HandleSeguroClan(userindex)
        Case ClientPacketID.home
            Call HandleHome(userindex)
        Case ClientPacketID.Consulta
            Call HandleConsulta(userindex)
        Case ClientPacketID.GetMapInfo
            Call HandleGetMapInfo(userindex)
        Case ClientPacketID.FinEvento
            Call HandleFinEvento(userindex)
        Case ClientPacketID.SeguroResu
            Call HandleSeguroResu(userindex)
        Case ClientPacketID.CuentaExtractItem
            Call HandleCuentaExtractItem(userindex)
        Case ClientPacketID.CuentaDeposit
            Call HandleCuentaDeposit(userindex)
        Case ClientPacketID.CreateEvent
            Call HandleCreateEvent(userindex)
        Case ClientPacketID.CommerceSendChatMessage
            Call HandleCommerceSendChatMessage(userindex)
        Case ClientPacketID.LogMacroClickHechizo
            Call HandleLogMacroClickHechizo(userindex)
        Case ClientPacketID.AddItemCrafting
            Call HandleAddItemCrafting(userindex)
        Case ClientPacketID.RemoveItemCrafting
            Call HandleRemoveItemCrafting(userindex)
        Case ClientPacketID.AddCatalyst
            Call HandleAddCatalyst(userindex)
        Case ClientPacketID.RemoveCatalyst
            Call HandleRemoveCatalyst(userindex)
        Case ClientPacketID.CraftItem
            Call HandleCraftItem(userindex)
        Case ClientPacketID.CloseCrafting
            Call HandleCloseCrafting(userindex)
        Case ClientPacketID.MoveCraftItem
            Call HandleMoveCraftItem(userindex)
        Case ClientPacketID.PetLeaveAll
            Call HandlePetLeaveAll(userindex)
        Case ClientPacketID.ResetChar
            Call HandleResetChar(userindex)
        Case ClientPacketID.resetearPersonaje
            Call HandleResetearPersonaje(userindex)
        Case ClientPacketID.DeleteItem
            Call HandleDeleteItem(userindex)
        Case ClientPacketID.FinalizarPescaEspecial
            Call HandleFinalizarPescaEspecial(userindex)
        Case ClientPacketID.RomperCania
            Call HandleRomperCania(userindex)
        Case ClientPacketID.RepeatMacro
            Call HandleRepeatMacro(userindex)
        Case ClientPacketID.CreateAccount
            Call HandleCreateAccount(userindex)
        Case ClientPacketID.LoginAccount
            Call HandleLoginAccount(userindex)
        Case ClientPacketID.DeleteCharacter
            Call HandleDeleteCharacter(userindex)
        Case Else
            Err.raise -1, "Invalid Message"
    End Select
    
    If (Message.GetAvailable() > 0) Then
        Err.raise &HDEADBEEF, "HandleIncomingData", "El paquete '" & PacketId & "' se encuentra en mal estado con '" & Message.GetAvailable() & "' bytes de mas por el usuario '" & UserList(userindex).name & "'"
    End If
    
HandleIncomingData_Err:
    
    Set Reader = Nothing

    If Err.Number <> 0 Then
        Call TraceError(Err.Number, Err.Description & vbNewLine & "PackedID: " & PacketId & vbNewLine & IIf(UserList(userindex).flags.UserLogged, "UserName: " & UserList(userindex).name, "UserIndex: " & userindex), "Protocol.HandleIncomingData", Erl)
        Call CloseSocket(userindex)
        
        HandleIncomingData = False
    End If
End Function

''
' Handles the "LoginExistingChar" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleLoginExistingChar(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        ''Last Modification: 01/12/08 Ladder
        '***************************************************

        On Error GoTo ErrHandler

        Dim user_name    As String

        user_name = Reader.ReadString8

        Call ConnectUser(userindex, user_name)

        Exit Sub
    
ErrHandler:
        Call TraceError(Err.Number, Err.Description, "Protocol.HandleLoginExistingChar", Erl)

End Sub


'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleLoginNewChar(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

        Dim name As String
        Dim race     As e_Raza
        Dim gender   As e_Genero
        Dim Hogar    As e_Ciudad
        Dim Class As e_Class
        Dim Head        As Integer

        name = Reader.ReadString8
110     race = Reader.ReadInt()
112     gender = Reader.ReadInt()
113     Class = Reader.ReadInt()
116     Head = Reader.ReadInt()
118     Hogar = Reader.ReadInt()

126     If PuedeCrearPersonajes = 0 Then
128         Call WriteShowMessageBox(userindex, "La creacion de personajes en este servidor se ha deshabilitado.")
130         Call CloseSocket(userindex)
            Exit Sub

        End If

132     If aClon.MaxPersonajes(UserList(userindex).IP) Then
134         Call WriteShowMessageBox(userindex, "Has creado demasiados personajes.")
136         Call CloseSocket(userindex)
            Exit Sub

        End If

        'Check if we reached MAX_PERSONAJES for this account after updateing the UserList(userindex).AccountID in the if above
        If GetPersonajesCountByIDDatabase(UserList(userindex).AccountID) >= MAX_PERSONAJES Then
            Call CloseSocket(userindex)
            Exit Sub
        End If
        
        If Not ConnectNewUser(userindex, name, race, gender, Class, Head, Hogar) Then
            Call CloseSocket(userindex)
            Exit Sub
        End If
        
        
        Exit Sub
    
ErrHandler:
     Call TraceError(Err.Number, Err.Description, "Protocol.HandleLoginNewChar", Erl)
End Sub


''
' Handles the "Talk" message.
'
' @param    UserIndex The index of the user sending the message.


Private Sub HandleTalk(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '13/01/2010: ZaMa - Now hidden on boat pirats recover the proper boat body.
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim chat As String
102         chat = Reader.ReadString8()
            
            
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.Talk
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "Talk", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
                        
            '[Consejeros & GMs]
104         If (.flags.Privilegios And (e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
106             Call LogGM(.name, "Dijo: " & chat)
            End If
    
       
132         If .flags.Silenciado = 1 Then
134             Call WriteLocaleMsg(userindex, "110", e_FontTypeNames.FONTTYPE_INFO, .flags.MinutosRestantes)
            Else
136             If LenB(chat) <> 0 Then

                    ' WyroX: Foto-denuncias - Push message
                    Dim i As Long
140                 For i = 1 To UBound(.flags.ChatHistory) - 1
142                     .flags.ChatHistory(i) = .flags.ChatHistory(i + 1)
                    Next
                    
144                 .flags.ChatHistory(UBound(.flags.ChatHistory)) = chat
                
146                 If .flags.Muerto = 1 Then
                        'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead(chat, .Char.CharIndex, CHAT_COLOR_DEAD_CHAR, UserList(UserIndex).Name))
148                     Call SendData(SendTarget.ToUsuariosMuertos, userindex, PrepareMessageChatOverHead(chat, .Char.CharIndex, CHAT_COLOR_DEAD_CHAR))
                    
                    Else
150                     Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageChatOverHead(chat, .Char.CharIndex, .flags.ChatColor))

                    End If

                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:
152     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTalk", Erl)
154

End Sub

''
' Handles the "Yell" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleYell(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim chat As String
102             chat = Reader.ReadString8()
        
104         If UserList(userindex).flags.Muerto = 1 Then
        
106             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                ' Call WriteConsoleMsg(UserIndex, "��Est�s muerto!! Los muertos no pueden comunicarse con el mundo de los vivos.", e_FontTypeNames.FONTTYPE_INFO)
            
            Else

                '[Consejeros & GMs]
108             If (.flags.Privilegios And (e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
110                 Call LogGM(.name, "Grito: " & chat)
                End If
            
                'I see you....
112             If .flags.Oculto > 0 And .flags.AdminInvisible = 0 Then
            
114                 .flags.Oculto = 0
                    .Counters.TiempoOcultar = 1
116                 .Counters.TiempoOculto = 0
                
118                 If .flags.Navegando = 1 Then
                    
                        'TODO: Revisar con WyroX
120                     If .clase = e_Class.Pirat Then
                    
                            ' Pierde la apariencia de fragata fantasmal
122                         Call EquiparBarco(userindex)
124                         Call WriteConsoleMsg(userindex, "�Has recuperado tu apariencia normal!", e_FontTypeNames.FONTTYPE_INFO)
126                         Call ChangeUserChar(userindex, .Char.Body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)
128                         Call RefreshCharStatus(userindex)
                        End If
    
                    Else
    
130                     If .flags.invisible = 0 Then
132                         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageSetInvisible(.Char.CharIndex, False))
134                         Call WriteConsoleMsg(userindex, "�Has vuelto a ser visible!", e_FontTypeNames.FONTTYPE_INFO)
    
                        End If
    
                    End If

                End If
            
136             If .flags.Silenciado = 1 Then
138                 Call WriteLocaleMsg(userindex, "110", e_FontTypeNames.FONTTYPE_VENENO, .flags.MinutosRestantes)
        
                    'Call WriteConsoleMsg(UserIndex, "Los administradores te han impedido hablar durante los proximos " & .flags.MinutosRestantes & " minutos debido a tu comportamiento.", e_FontTypeNames.FONTTYPE_VENENO)
                Else

140                 If LenB(chat) <> 0 Then
                        ' WyroX: Foto-denuncias - Push message
                        Dim i As Long
144                     For i = 1 To UBound(.flags.ChatHistory) - 1
146                         .flags.ChatHistory(i) = .flags.ChatHistory(i + 1)
                        Next
                    
148                     .flags.ChatHistory(UBound(.flags.ChatHistory)) = chat

150                     Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageChatOverHead(chat, .Char.CharIndex, vbRed))
               
                    End If

                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:

152     Call TraceError(Err.Number, Err.Description, "Protocol.HandleYell", Erl)
154

End Sub

''
' Handles the "Whisper" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWhisper(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim chat            As String
            Dim targetCharIndex As String
            Dim targetUserIndex As Integer

102         targetCharIndex = Reader.ReadString8()
104         chat = Reader.ReadString8()
    
106         If CompararPrivilegios(.flags.Privilegios, UserDarPrivilegioLevel(targetCharIndex)) < 0 Then Exit Sub
        
108         targetUserIndex = NameIndex(targetCharIndex)

110         If targetUserIndex <= 0 Then 'existe el usuario destino?
112            ' Call WriteConsoleMsg(UserIndex, "Usuario offline o inexistente.", e_FontTypeNames.FONTTYPE_INFO)

            Else

114             If EstaPCarea(userindex, targetUserIndex) Then

116                 If LenB(chat) <> 0 Then
                        ' WyroX: Foto-denuncias - Push message
                        Dim i As Long

120                     For i = 1 To UBound(.flags.ChatHistory) - 1
122                         .flags.ChatHistory(i) = .flags.ChatHistory(i + 1)
                        Next
                        
124                     .flags.ChatHistory(UBound(.flags.ChatHistory)) = chat
            
126                     Call SendData(SendTarget.ToSuperioresArea, userindex, PrepareMessageChatOverHead(chat, .Char.CharIndex, RGB(157, 226, 20)))
                        
128                     Call WriteChatOverHead(userindex, chat, .Char.CharIndex, RGB(157, 226, 20))
130                     Call WriteChatOverHead(targetUserIndex, chat, .Char.CharIndex, RGB(157, 226, 20))
                        'Call WriteConsoleMsg(UserIndex, "[" & .Name & "] " & chat, e_FontTypeNames.FONTTYPE_MP)
                        'Call WriteConsoleMsg(targetUserIndex, "[" & .Name & "] " & chat, e_FontTypeNames.FONTTYPE_MP)
132                     Call WritePlayWave(targetUserIndex, e_FXSound.MP_SOUND, NO_3D_SOUND, NO_3D_SOUND)

                    End If

'                Else
'134                 Call WriteConsoleMsg(UserIndex, "[" & .Name & "] " & chat, e_FontTypeNames.FONTTYPE_MP)
'136                 Call WriteConsoleMsg(targetUserIndex, "[" & .Name & "] " & chat, e_FontTypeNames.FONTTYPE_MP)
'138                 Call WritePlayWave(targetUserIndex, e_FXSound.MP_SOUND, NO_3D_SOUND, NO_3D_SOUND)

                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:

140     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWhisper", Erl)
142

End Sub

''
' Handles the "Walk" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWalk(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo HandleWalk_Err

        Dim Heading As e_Heading
    
100     With UserList(userindex)

102         Heading = Reader.ReadInt()
            Dim PacketCount As Long
            PacketCount = Reader.ReadInt
            
            If .flags.Muerto = 0 Then
                If .flags.Navegando Then
                    Call verifyTimeStamp(PacketCount, .PacketCounters(PacketNames.Sailing), .PacketTimers(PacketNames.Sailing), .MacroIterations(PacketNames.Sailing), userindex, "Sailing", PacketTimerThreshold(PacketNames.Sailing), MacroIterations(PacketNames.Sailing))
                Else
                    Call verifyTimeStamp(PacketCount, .PacketCounters(PacketNames.Walk), .PacketTimers(PacketNames.Walk), .MacroIterations(PacketNames.Walk), userindex, "Walk", PacketTimerThreshold(PacketNames.Walk), MacroIterations(PacketNames.Walk))
                End If
            End If
            
            
            If .flags.PescandoEspecial Then
                .Stats.NumObj_PezEspecial = 0
                .flags.PescandoEspecial = False
            End If
            
104         If .flags.Paralizado = 0 And .flags.Inmovilizado = 0 Then
                
106             If .flags.Comerciando Or .flags.Crafteando <> 0 Then Exit Sub

108             If .flags.Meditando Then
            
                    'Stop meditating, next action will start movement.
110                 .flags.Meditando = False
112                 UserList(userindex).Char.FX = 0
114                 Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageMeditateToggle(UserList(userindex).Char.CharIndex, 0))

                End If
                
                Dim CurrentTick As Long
116                 CurrentTick = GetTickCount
            
                'Prevent SpeedHack (refactored by WyroX)
118             If Not EsGM(userindex) Then
                    Dim ElapsedTimeStep As Long, MinTimeStep As Long, DeltaStep As Single
120                 ElapsedTimeStep = CurrentTick - .Counters.LastStep
122                 MinTimeStep = .Intervals.Caminar / .Char.speeding
124                 DeltaStep = (MinTimeStep - ElapsedTimeStep) / MinTimeStep

126                 If DeltaStep > 0 Then
                
128                     .Counters.SpeedHackCounter = .Counters.SpeedHackCounter + DeltaStep
                
130                     If .Counters.SpeedHackCounter > MaximoSpeedHack Then
                            'Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Administraci�n � Posible uso de SpeedHack del usuario " & .name & ".", e_FontTypeNames.FONTTYPE_SERVER))
132                         Call WritePosUpdate(userindex)
                            Exit Sub

                        End If

                    Else
                
134                     .Counters.SpeedHackCounter = .Counters.SpeedHackCounter + DeltaStep * 5

136                     If .Counters.SpeedHackCounter < 0 Then .Counters.SpeedHackCounter = 0

                    End If

                End If
            
                'Move user
138             If MoveUserChar(userindex, Heading) Then
            
                    ' Save current step for anti-sh
140                 .Counters.LastStep = CurrentTick
                
142                 If UserList(userindex).Grupo.EnGrupo Then
144                     Call CompartirUbicacion(userindex)

                    End If
    
                    'Stop resting if needed
146                 If .flags.Descansar Then
148                     .flags.Descansar = False
                        
150                     Call WriteRestOK(userindex)
                        'Call WriteConsoleMsg(UserIndex, "Has dejado de descansar.", e_FontTypeNames.FONTTYPE_INFO)
152                     Call WriteLocaleMsg(userindex, "178", e_FontTypeNames.FONTTYPE_INFO)
    
                    End If
                        
154                 Call CancelExit(userindex)
                        
                    'Esta usando el /HOGAR, no se puede mover
156                 If .flags.Traveling = 1 Then
158                     .flags.Traveling = 0
160                     .Counters.goHome = 0
162                     Call WriteConsoleMsg(userindex, "Has cancelado el viaje a casa.", e_FontTypeNames.FONTTYPE_INFO)

                    End If

                    ' Si no pudo moverse
                Else
164                 .Counters.LastStep = 0
166                 Call WritePosUpdate(userindex)

                End If

            Else    'paralized

168             If Not .flags.UltimoMensaje = 1 Then
170                 .flags.UltimoMensaje = 1
                    'Call WriteConsoleMsg(UserIndex, "No podes moverte porque estas paralizado.", e_FontTypeNames.FONTTYPE_INFO)
172                 Call WriteLocaleMsg(userindex, "54", e_FontTypeNames.FONTTYPE_INFO)

                End If

            End If
            
            'Can't move while hidden except he is a thief
174         If .flags.Oculto = 1 And .flags.AdminInvisible = 0 Then
                
176             If .clase <> e_Class.Thief And .clase <> e_Class.Bandit Then
            
178                 .flags.Oculto = 0
                    .Counters.TiempoOcultar = 1
180                 .Counters.TiempoOculto = 0
                
182                 If .flags.Navegando = 1 Then
                        
184                     If .clase = e_Class.Pirat Then
                            ' Pierde la apariencia de fragata fantasmal
186                         Call EquiparBarco(userindex)
188                         Call WriteConsoleMsg(userindex, "�Has recuperado tu apariencia normal!", e_FontTypeNames.FONTTYPE_INFO)
190                         Call ChangeUserChar(userindex, .Char.Body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)
192                         Call RefreshCharStatus(userindex)
                        End If
    
                    Else
    
                        'If not under a spell effect, show char
194                     If .flags.invisible = 0 Then
                            'Call WriteConsoleMsg(UserIndex, "Has vuelto a ser visible.", e_FontTypeNames.FONTTYPE_INFO)
196                         Call WriteLocaleMsg(userindex, "307", e_FontTypeNames.FONTTYPE_INFO)
198                         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageSetInvisible(.Char.CharIndex, False))

                        End If
    
                    End If
    
                End If
                
            End If

        End With

        Exit Sub

HandleWalk_Err:
200     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWalk", Erl)
202
        
End Sub

''
' Handles the "RequestPositionUpdate" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestPositionUpdate(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo HandleRequestPositionUpdate_Err

100     Call WritePosUpdate(userindex)
  
        Exit Sub

HandleRequestPositionUpdate_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandlRequestPositionUpdate", Erl)
104
        
End Sub

''
' Handles the "Attack" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleAttack(ByVal userindex As Integer)
        
        On Error GoTo HandleAttack_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 10/01/08
        'Last Modified By: Lucas Tavolaro Ortiz (Tavo)
        ' 10/01/2008: Tavo - Se cancela la salida del juego si el user esta saliendo
        '***************************************************
        
100     With UserList(userindex)
        
        
            
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.Attack
            
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "Attack", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
            
            'If dead, can't attack
102         If .flags.Muerto = 1 Then
104             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "�No podes atacar a nadie porque estas muerto!!.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'If equiped weapon is ranged, can't attack this way
106         If .Invent.WeaponEqpObjIndex > 0 Then

108             If ObjData(.Invent.WeaponEqpObjIndex).Proyectil = 1 Then
110                 Call WriteConsoleMsg(userindex, "No pod�s usar as� esta arma.", e_FontTypeNames.FONTTYPE_INFOIAO)
                    Exit Sub

                End If

            End If
        
112         If .Invent.HerramientaEqpObjIndex > 0 Then
114             Call WriteConsoleMsg(userindex, "Para atacar debes desequipar la herramienta.", e_FontTypeNames.FONTTYPE_INFOIAO)
                Exit Sub

            End If
        
116         If UserList(userindex).flags.Meditando Then
118             UserList(userindex).flags.Meditando = False
120             UserList(userindex).Char.FX = 0
122             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageMeditateToggle(UserList(userindex).Char.CharIndex, 0))

            End If
        
            'If exiting, cancel
124         Call CancelExit(userindex)
        
            'Attack!
126         Call UsuarioAtaca(userindex)
            
            'I see you...
128         If .flags.Oculto > 0 And .flags.AdminInvisible = 0 Then
        
130             .flags.Oculto = 0
                .Counters.TiempoOcultar = 1
132             .Counters.TiempoOculto = 0
                
134             If .flags.Navegando = 1 Then

136                 If .clase = e_Class.Pirat Then
                        ' Pierde la apariencia de fragata fantasmal
138                     Call EquiparBarco(userindex)
140                     Call WriteConsoleMsg(userindex, "�Has recuperado tu apariencia normal!", e_FontTypeNames.FONTTYPE_INFO)
142                     Call ChangeUserChar(userindex, .Char.Body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)
144                     Call RefreshCharStatus(userindex)
                    End If
    
                Else
    
146                 If .flags.invisible = 0 Then
148                     Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageSetInvisible(.Char.CharIndex, False))
                        'Call WriteConsoleMsg(UserIndex, "�Has vuelto a ser visible!", e_FontTypeNames.FONTTYPE_INFO)
150                     Call WriteLocaleMsg(userindex, "307", e_FontTypeNames.FONTTYPE_INFOIAO)
    
                    End If
    
                End If
    
            End If

        End With

        Exit Sub

HandleAttack_Err:
152     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAttack", Erl)
154
        
End Sub

''
' Handles the "PickUp" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandlePickUp(ByVal userindex As Integer)
        
        On Error GoTo HandlePickUp_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'If dead, it can't pick up objects
102         If .flags.Muerto = 1 Then
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!! Los muertos no pueden tomar objetos.", e_FontTypeNames.FONTTYPE_INFO)
104             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Lower rank administrators can't pick up items
106         If (.flags.Privilegios And (e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
108             Call WriteConsoleMsg(userindex, "No pod�s tomar ningun objeto.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
110         Call PickObj(userindex)

        End With
        
        Exit Sub

HandlePickUp_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePickUp", Erl)
114
        
End Sub

''
' Handles the "SafeToggle" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSafeToggle(ByVal userindex As Integer)
        
        On Error GoTo HandleSafeToggle_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)
            
            Dim cambiaSeguro As Boolean
            cambiaSeguro = False
            
            If .GuildIndex > 0 And (GuildAlignmentIndex(.GuildIndex) = e_ALINEACION_GUILD.ALINEACION_CIUDADANA Or GuildAlignmentIndex(.GuildIndex) = e_ALINEACION_GUILD.ALINEACION_ARMADA) Then
                cambiaSeguro = False
            Else
                cambiaSeguro = True
            End If
             
            If cambiaSeguro Or .flags.Seguro = 0 Then
                If esCiudadano(userindex) Then
102                 If .flags.Seguro Then
104                     Call WriteSafeModeOff(userindex)
                    Else
106                     Call WriteSafeModeOn(userindex)
                    End If
                    
108                 .flags.Seguro = Not .flags.Seguro
                Else
                    Call WriteConsoleMsg(userindex, "Solo los ciudadanos pueden cambiar el seguro.", e_FontTypeNames.FONTTYPE_TALK)
                End If
            Else
                Call WriteConsoleMsg(userindex, "Debes abandonar el clan para poder sacar el seguro.", e_FontTypeNames.FONTTYPE_TALK)
            End If

        End With

        Exit Sub

HandleSafeToggle_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSafeToggle", Erl)
112
        
End Sub

' Handles the "PartySafeToggle" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandlePartyToggle(ByVal userindex As Integer)
        
        On Error GoTo HandlePartyToggle_Err
        
        '***************************************************
        'Author: Rapsodius
        'Creation Date: 10/10/07
        '***************************************************
100     With UserList(userindex)
        
102         .flags.SeguroParty = Not .flags.SeguroParty
        
104         If .flags.SeguroParty Then
106             Call WritePartySafeOn(userindex)
            
            Else
108             Call WritePartySafeOff(userindex)

            End If

        End With

        Exit Sub

HandlePartyToggle_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePartyToggle", Erl)
112
        
End Sub

Private Sub HandleSeguroClan(ByVal userindex As Integer)
        
        On Error GoTo HandleSeguroClan_Err

        '***************************************************
        'Author: Ladder
        'Date: 31/10/20
        '***************************************************
100     With UserList(userindex)

102         .flags.SeguroClan = Not .flags.SeguroClan

104         Call WriteClanSeguro(userindex, .flags.SeguroClan)

        End With

        Exit Sub

HandleSeguroClan_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSeguroClan", Erl)
108
        
End Sub

''
' Handles the "RequestGuildLeaderInfo" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestGuildLeaderInfo(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo HandleRequestGuildLeaderInfo_Err

100     Call modGuilds.SendGuildLeaderInfo(userindex)

        Exit Sub

HandleRequestGuildLeaderInfo_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestGuildLeaderInfo", Erl)
104
        
End Sub

''
' Handles the "RequestAtributes" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestAtributes(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        
        On Error GoTo HandleRequestAtributes_Err

100     Call WriteAttributes(userindex)

        Exit Sub

HandleRequestAtributes_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestAtributes", Erl)
104
        
End Sub

''
' Handles the "RequestSkills" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestSkills(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        
        On Error GoTo HandleRequestSkills_Err

100     Call WriteSendSkills(userindex)

        Exit Sub

HandleRequestSkills_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestSkills", Erl)
104
        
End Sub

''
' Handles the "RequestMiniStats" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestMiniStats(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        
        On Error GoTo HandleRequestMiniStats_Err

100     Call WriteMiniStats(userindex)

        Exit Sub

HandleRequestMiniStats_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestMiniStats", Erl)
104
        
End Sub

''
' Handles the "CommerceEnd" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCommerceEnd(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo HandleCommerceEnd_Err

        'User quits commerce mode
100     If UserList(userindex).flags.TargetNPC <> 0 Then
    
102         If NpcList(UserList(userindex).flags.TargetNPC).SoundClose <> 0 Then
104             Call WritePlayWave(userindex, NpcList(UserList(userindex).flags.TargetNPC).SoundClose, NO_3D_SOUND, NO_3D_SOUND)

            End If

        End If

106     UserList(userindex).flags.Comerciando = False

108     Call WriteCommerceEnd(userindex)
 
        Exit Sub

HandleCommerceEnd_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCommerceEnd", Erl)
112
        
End Sub

''
' Handles the "UserCommerceEnd" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUserCommerceEnd(ByVal userindex As Integer)
        
        On Error GoTo HandleUserCommerceEnd_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

        
        
        
            'Quits commerce mode with user
            
102         If .ComUsu.DestUsu > 0 Then
                If UserList(.ComUsu.DestUsu).ComUsu.DestUsu = userindex Then
104                 Call WriteConsoleMsg(.ComUsu.DestUsu, .name & " ha dejado de comerciar con vos.", e_FontTypeNames.FONTTYPE_TALK)
106                 Call FinComerciarUsu(.ComUsu.DestUsu)
                
                'Send data in the outgoing buffer of the other user

                End If
            End If
        
108         Call FinComerciarUsu(userindex)

        End With
        
        Exit Sub

HandleUserCommerceEnd_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUserCommerceEnd", Erl)
112
        
End Sub

''
' Handles the "BankEnd" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBankEnd(ByVal userindex As Integer)
        
        On Error GoTo HandleBankEnd_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'User exits banking mode
102         .flags.Comerciando = False
        
104         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessagePlayWave("171", UserList(userindex).Pos.X, UserList(userindex).Pos.Y))
106         Call WriteBankEnd(userindex)

        End With
        
        Exit Sub

HandleBankEnd_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBankEnd", Erl)
110
        
End Sub

''
' Handles the "UserCommerceOk" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUserCommerceOk(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        
        On Error GoTo HandleUserCommerceOk_Err

        'Trade accepted
100     Call AceptarComercioUsu(userindex)
        
        Exit Sub

HandleUserCommerceOk_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUserCommerceOk", Erl)
104
        
End Sub

''
' Handles the "UserCommerceReject" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUserCommerceReject(ByVal userindex As Integer)
        
        On Error GoTo HandleUserCommerceReject_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        Dim otherUser As Integer
    
100     With UserList(userindex)

102         otherUser = .ComUsu.DestUsu
        
            'Offer rejected
104         If otherUser > 0 Then
106             If UserList(otherUser).flags.UserLogged Then
108                 Call WriteConsoleMsg(otherUser, .name & " ha rechazado tu oferta.", e_FontTypeNames.FONTTYPE_TALK)
110                 Call FinComerciarUsu(otherUser)
                
                    'Send data in the outgoing buffer of the other user

                End If

            End If
        
112         Call WriteConsoleMsg(userindex, "Has rechazado la oferta del otro usuario.", e_FontTypeNames.FONTTYPE_TALK)
114         Call FinComerciarUsu(userindex)

        End With
        
        Exit Sub

HandleUserCommerceReject_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUserCommerceReject", Erl)
118
        
End Sub

''
' Handles the "Drop" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleDrop(ByVal userindex As Integer)
        
        On Error GoTo HandleDrop_Err
        
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 07/25/09
        '07/25/09: Marco - Agregue un checkeo para patear a los usuarios que tiran items mientras comercian.
        '***************************************************

        Dim Slot   As Byte
        Dim amount As Long
    
100     With UserList(userindex)

102         Slot = Reader.ReadInt()
104         amount = Reader.ReadInt()
            
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.Drop
            
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "Drop", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
            
106         If Not IntervaloPermiteTirar(userindex) Then Exit Sub

108         If amount <= 0 Then Exit Sub

            'low rank admins can't drop item. Neither can the dead nor those sailing or riding a horse.
110         If .flags.Muerto = 1 Then Exit Sub
                      
            'If the user is trading, he can't drop items => He's cheating, we kick him.
112         If .flags.Comerciando Then Exit Sub
    
            'Si esta navegando y no es pirata, no dejamos tirar items al agua.
114         If .flags.Navegando = 1 And Not .clase = e_Class.Pirat Then
116             Call WriteConsoleMsg(userindex, "Solo los Piratas pueden tirar items en altamar", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
            
118         If .flags.Montado = 1 Then
120             Call WriteConsoleMsg(userindex, "Debes descender de tu montura para dejar objetos en el suelo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

            'Are we dropping gold or other items??
122         If Slot = FLAGORO Then
                If amount > 100000 Then amount = 100000
124             Call TirarOro(amount, userindex)
            
            Else
                If Slot <= getMaxInventorySlots(userindex) Then
                '04-05-08 Ladder
126                 If (.flags.Privilegios And e_PlayerType.Admin) <> 16 Then
128                     If EsNewbie(userindex) And ObjData(.Invent.Object(Slot).ObjIndex).Newbie = 1 Then
130                         Call WriteConsoleMsg(userindex, "No se pueden tirar los objetos Newbies.", e_FontTypeNames.FONTTYPE_INFO)
                            Exit Sub
                        End If
                
132                     If ObjData(.Invent.Object(Slot).ObjIndex).Intirable = 1 And Not EsGM(userindex) Then
134                         Call WriteConsoleMsg(userindex, "Acci�n no permitida.", e_FontTypeNames.FONTTYPE_INFO)
                            Exit Sub
136                     ElseIf ObjData(.Invent.Object(Slot).ObjIndex).Intirable = 1 And EsGM(userindex) Then
138                         If Slot <= UserList(userindex).CurrentInventorySlots And Slot > 0 Then
140                             If .Invent.Object(Slot).ObjIndex = 0 Then Exit Sub
142                             Call DropObj(userindex, Slot, amount, .Pos.Map, .Pos.X, .Pos.Y)
                            End If
                            Exit Sub
                        End If
                    
144                     If ObjData(.Invent.Object(Slot).ObjIndex).Instransferible = 1 Then
146                         Call WriteConsoleMsg(userindex, "Acci�n no permitida.", e_FontTypeNames.FONTTYPE_INFO)
                            Exit Sub
                        End If
                
    
                    End If
        
148                 If ObjData(.Invent.Object(Slot).ObjIndex).OBJType = e_OBJType.otBarcos And UserList(userindex).flags.Navegando Then
150                     Call WriteConsoleMsg(userindex, "Para tirar la barca deberias estar en tierra firme.", e_FontTypeNames.FONTTYPE_INFO)
                        Exit Sub
                    End If
                Else
                    'ver de banear al usuario
                    'Call BanearIP(0, UserList(UserIndex).name, UserList(UserIndex).IP, UserList(UserIndex).Cuenta)
                    Call LogEdicionPaquete("El usuario " & UserList(userindex).name & " edit� el slot del inventario | Valor: " & Slot & ".")
                End If
        
                '04-05-08 Ladder
        
                'Only drop valid slots
152             If Slot <= UserList(userindex).CurrentInventorySlots And Slot > 0 Then
            
154                 If .Invent.Object(Slot).ObjIndex = 0 Then Exit Sub

156                 Call DropObj(userindex, Slot, amount, .Pos.Map, .Pos.X, .Pos.Y)

                End If

            End If

        End With
        
        Exit Sub

HandleDrop_Err:
158     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDrop", Erl)
160
        
End Sub
Private Function verifyTimeStamp(ByVal ActualCount As Long, ByRef LastCount As Long, ByRef LastTick As Long, ByRef Iterations, ByVal userindex As Integer, ByVal PacketName As String, Optional ByVal DeltaThreshold As Long = 100, Optional ByVal MaxIterations As Long = 5, Optional ByVal CloseClient As Boolean = False) As Boolean
    
    Dim Ticks As Long, Delta As Long
    Ticks = GetTickCount
    
    Delta = (Ticks - LastTick)
    LastTick = Ticks

    'Controlamos secuencia para ver que no haya paquetes duplicados.
    If ActualCount <= LastCount Then
        Call SendData(SendTarget.ToGM, userindex, PrepareMessageConsoleMsg("Paquete grabado: " & PacketName & " | Cuenta: " & UserList(userindex).Cuenta & " | Ip: " & UserList(userindex).IP & " (Baneado automaticamente)", e_FontTypeNames.FONTTYPE_INFOBOLD))
        Call LogEdicionPaquete("El usuario " & UserList(userindex).name & " edit� el paquete " & PacketName & ".")
        LastCount = ActualCount
        Call CloseSocket(userindex)
        Exit Function
    End If
    
    'controlamos speedhack/macro
    If Delta < DeltaThreshold Then
        Iterations = Iterations + 1
        If Iterations >= MaxIterations Then
            'Call WriteShowMessageBox(UserIndex, "Relajate and� a tomarte un t� con Gulfas.")
            verifyTimeStamp = False
            'Call LogMacroServidor("El usuario " & UserList(UserIndex).name & " iter� el paquete " & PacketName & " " & MaxIterations & " veces.")
            Call SendData(SendTarget.ToAdmins, userindex, PrepareMessageConsoleMsg("Control de macro---> El usuario " & UserList(userindex).name & "| Revisar --> " & PacketName & " (Env�os: " & MaxIterations & ").", e_FontTypeNames.FONTTYPE_INFOBOLD))
            'Call WriteCerrarleCliente(UserIndex)
            'Call CloseSocket(UserIndex)
            LastCount = ActualCount
            Iterations = 0
            Debug.Print "CIERRO CLIENTE"
        End If
        'Exit Function
    Else
        Iterations = 0
    End If
        
    verifyTimeStamp = True
    LastCount = ActualCount
End Function


''
' Handles the "CastSpell" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCastSpell(ByVal userindex As Integer) ', ByVal server_crc As Long)
        
        On Error GoTo HandleCastSpell_Err
        
        
        
100     With UserList(userindex)

            
            Dim Spell As Byte
102         Spell = Reader.ReadInt()

            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.CastSpell
            
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "CastSpell", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
            
           ' Dim client_packet_crc As Long
           ' client_packet_crc = Reader.ReadInt64
            
            
            'If server_crc <> client_packet_crc Then
            '    If actualPacket_ts <= .PacketTimers.TS_CastSpell Then
            '        Call WriteShowMessageBox(UserIndex, "Se te cerr� por GordonSui")
            '        Call CloseSocket(UserIndex)
            '    End If
            'End If
            
            
104         If .flags.Muerto = 1 Then
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!.", e_FontTypeNames.FONTTYPE_INFO)
106             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
108         .flags.Hechizo = Spell
            
        
110         If .flags.Hechizo < 1 Or .flags.Hechizo > MAXUSERHECHIZOS Then
112             .flags.Hechizo = 0
            End If
        
114         If .flags.Hechizo <> 0 Then

116             If (.flags.Privilegios And e_PlayerType.Consejero) = 0 Then
                    
                    If .Stats.UserHechizos(Spell) <> 0 Then
                    
120                     If Hechizos(.Stats.UserHechizos(Spell)).AutoLanzar = 1 Then
122                         UserList(userindex).flags.TargetUser = userindex
124                         Call LanzarHechizo(.flags.Hechizo, userindex)
    
                        Else
                            If Hechizos(.Stats.UserHechizos(Spell)).AreaAfecta > 0 Then
126                             Call WriteWorkRequestTarget(userindex, e_Skill.Magia, True, Hechizos(.Stats.UserHechizos(Spell)).AreaRadio)
                            Else
                                Call WriteWorkRequestTarget(userindex, e_Skill.Magia)
                            End If
                        End If
                    
                    End If
                    
                End If

            End If
        
        End With
        
        Exit Sub

HandleCastSpell_Err:
128     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCastSpell", Erl)
130
        
End Sub

''
' Handles the "LeftClick" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleLeftClick(ByVal userindex As Integer)
        
        On Error GoTo HandleLeftClick_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim X As Byte
            Dim Y As Byte
        
102         X = Reader.ReadInt()
104         Y = Reader.ReadInt()
            
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.LeftClick

            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "LeftClick", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
            
106         Call LookatTile(userindex, .Pos.Map, X, Y)

        End With

        Exit Sub

HandleLeftClick_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleLeftClick", Erl)
110
        
End Sub

''
' Handles the "DoubleClick" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleDoubleClick(ByVal userindex As Integer)
        
        On Error GoTo HandleDoubleClick_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim X As Byte
            Dim Y As Byte
        
102         X = Reader.ReadInt()
104         Y = Reader.ReadInt()
        
106         Call Accion(userindex, .Pos.Map, X, Y)

        End With
        
        Exit Sub

HandleDoubleClick_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDoubleClick", Erl)
110
        
End Sub

''
' Handles the "Work" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWork(ByVal userindex As Integer)
        
        On Error GoTo HandleWork_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 13/01/2010
        '13/01/2010: ZaMa - El pirata se puede ocultar en barca
        '***************************************************

100     With UserList(userindex)

            Dim Skill As e_Skill
102             Skill = Reader.ReadInt()
            
            
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.Work
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "Work", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
            
            
104         If UserList(userindex).flags.Muerto = 1 Then
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!.", e_FontTypeNames.FONTTYPE_INFO)
106             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'If exiting, cancel
108         Call CancelExit(userindex)
        
110         Select Case Skill

                Case Robar, Magia, Domar
112                 Call WriteWorkRequestTarget(userindex, Skill)

114             Case Ocultarse

116                 If .flags.Montado = 1 Then

                        '[CDT 17-02-2004]
118                     If Not .flags.UltimoMensaje = 3 Then
120                         Call WriteConsoleMsg(userindex, "No pod�s ocultarte si est�s montado.", e_FontTypeNames.FONTTYPE_INFO)
122                         .flags.UltimoMensaje = 3

                        End If

                        '[/CDT]
                        Exit Sub

                    End If

124                 If .flags.Oculto = 1 Then

                        '[CDT 17-02-2004]
126                     If Not .flags.UltimoMensaje = 2 Then
128                         Call WriteLocaleMsg(userindex, "55", e_FontTypeNames.FONTTYPE_INFO)
                            'Call WriteConsoleMsg(UserIndex, "Ya est�s oculto.", e_FontTypeNames.FONTTYPE_INFO)
130                         .flags.UltimoMensaje = 2

                        End If

                        '[/CDT]
                        Exit Sub

                    End If
                    
132                 If .flags.EnReto Then
134                     Call WriteConsoleMsg(userindex, "No pod�s ocultarte durante un reto.", e_FontTypeNames.FONTTYPE_INFO)
                        Exit Sub

                    End If
                    
136                 If .flags.EnConsulta Then
138                     Call WriteConsoleMsg(userindex, "No pod�s ocultarte si estas en consulta.", e_FontTypeNames.FONTTYPE_INFO)
                        Exit Sub
    
                    End If
                    
                    If .flags.invisible Then
139                     Call WriteConsoleMsg(userindex, "No pod�s ocultarte si est�s invisible.", e_FontTypeNames.FONTTYPE_INFO)
                        Exit Sub
    
                    End If
                    
140                 If MapInfo(.Pos.Map).SinInviOcul Then
142                     Call WriteConsoleMsg(userindex, "Una fuerza divina te impide ocultarte en esta zona.", e_FontTypeNames.FONTTYPE_INFO)
                        Exit Sub

                    End If
                    
144                 Call DoOcultarse(userindex)

            End Select

        End With
        
        Exit Sub

HandleWork_Err:
146     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWork", Erl)
148
        
End Sub

''
' Handles the "UseSpellMacro" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUseSpellMacro(ByVal userindex As Integer)
        
        On Error GoTo HandleUseSpellMacro_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)
#If STRESSER = 1 Then
    Exit Sub
#End If
102         Call SendData(SendTarget.ToAdmins, userindex, PrepareMessageConsoleMsg(.name & " fue expulsado por Anti-macro de hechizos", e_FontTypeNames.FONTTYPE_VENENO))
104         Call WriteShowMessageBox(userindex, "Has sido expulsado por usar macro de hechizos. Recomendamos leer el reglamento sobre el tema macros")
        
106         Call CloseSocket(userindex)

        End With
        
        Exit Sub

HandleUseSpellMacro_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUseSpellMacro", Erl)
110
        
End Sub

''
' Handles the "UseItem" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUseItem(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo HandleUseItem_Err
    
100     With UserList(userindex)

            Dim Slot As Byte
102         Slot = Reader.ReadInt()
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
            
            Dim Packet_ID As Long
            Packet_ID = PacketNames.UseItem
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "UseItem", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
            Debug.Print "LLEGA PAQUETE"
104         If Slot <= UserList(userindex).CurrentInventorySlots And Slot > 0 Then
106             If .Invent.Object(Slot).ObjIndex = 0 Then Exit Sub

108             Call UseInvItem(userindex, Slot, 1)
                
            End If

        End With

        Exit Sub

HandleUseItem_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUseItem", Erl)
112
        
End Sub

''
' Handles the "UseItem" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUseItemU(ByVal userindex As Integer)
        
        On Error GoTo HandleUseItemU_Err
    
100     With UserList(userindex)

            Dim Slot As Byte
102         Slot = Reader.ReadInt()

            
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
            
            Dim Packet_ID As Long
            Packet_ID = PacketNames.UseItemU
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "UseItemU", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
            
104         If Slot <= UserList(userindex).CurrentInventorySlots And Slot > 0 Then
106             If .Invent.Object(Slot).ObjIndex = 0 Then Exit Sub

108             Call UseInvItem(userindex, Slot, 0)
                
            End If

        End With

        Exit Sub

HandleUseItemU_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUseItemU", Erl)
112
        
End Sub

''
' Handles the "CraftBlacksmith" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCraftBlacksmith(ByVal userindex As Integer)
        
        On Error GoTo HandleCraftBlacksmith_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

            Dim Item As Integer
102             Item = Reader.ReadInt()
        
104         If Item < 1 Then Exit Sub
        
            ' If ObjData(Item).SkHerreria = 0 Then Exit Sub
        
106         Call HerreroConstruirItem(userindex, Item)

        Exit Sub

HandleCraftBlacksmith_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCraftBlacksmith", Erl)
110
        
End Sub

''
' Handles the "CraftCarpenter" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCraftCarpenter(ByVal userindex As Integer)
        
        On Error GoTo HandleCraftCarpenter_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

            Dim Item As Integer
102             Item = Reader.ReadInt()
        
104         If Item = 0 Then Exit Sub

106         Call CarpinteroConstruirItem(userindex, Item)

        Exit Sub

HandleCraftCarpenter_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCraftCarpenter", Erl)
110
        
End Sub

Private Sub HandleCraftAlquimia(ByVal userindex As Integer)
        
        On Error GoTo HandleCraftAlquimia_Err
        
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

            Dim Item As Integer
102             Item = Reader.ReadInt()
        
104         If Item < 1 Then Exit Sub

        Exit Sub

HandleCraftAlquimia_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCraftAlquimia", Erl)
108
        
End Sub

Private Sub HandleCraftSastre(ByVal userindex As Integer)
        
        On Error GoTo HandleCraftSastre_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

            Dim Item As Integer
102             Item = Reader.ReadInt()
        
104         If Item < 1 Then Exit Sub

106         Call SastreConstruirItem(userindex, Item)

        Exit Sub

HandleCraftSastre_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCraftSastre", Erl)
110
        
End Sub
''
' Handles the "WorkLeftClick" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWorkLeftClick(ByVal userindex As Integer)
        
        On Error GoTo HandleWorkLeftClick_Err
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)
        
            Dim X        As Byte
            Dim Y        As Byte

            Dim Skill    As e_Skill
            Dim DummyInt As Integer

            Dim tU       As Integer   'Target user
            Dim tN       As Integer   'Target NPC
        
102         X = Reader.ReadInt()
104         Y = Reader.ReadInt()
            
106         Skill = Reader.ReadInt()

            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.WorkLeftClick

            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "WorkLeftClick", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub

            .Trabajo.Target_X = X
            .Trabajo.Target_Y = Y
            .Trabajo.TargetSkill = Skill
            
108         If .flags.Muerto = 1 Or .flags.Descansar Or Not InMapBounds(.Pos.Map, X, Y) Then Exit Sub

110         If Not InRangoVision(userindex, X, Y) Then
112             Call WritePosUpdate(userindex)
                Exit Sub

            End If
            
114         If .flags.Meditando Then
116             .flags.Meditando = False
118             .Char.FX = 0
120             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageMeditateToggle(.Char.CharIndex, 0))

            End If
        
            'If exiting, cancel
122         Call CancelExit(userindex)
            
124         Select Case Skill

                    Dim consumirMunicion As Boolean

                Case e_Skill.Proyectiles
            
                    'Check attack interval
126                 If Not IntervaloPermiteMagiaGolpe(userindex, False) Then Exit Sub

                    'Check Magic interval
128                 If Not IntervaloPermiteGolpeMagia(userindex, False) Then Exit Sub

                    'Check bow's interval
130                 If Not IntervaloPermiteUsarArcos(userindex) Then Exit Sub
                
                    'Make sure the item is valid and there is ammo equipped.
132                 With .Invent

134                     If .WeaponEqpObjIndex = 0 Then
136                         DummyInt = 1
138                     ElseIf .WeaponEqpSlot < 1 Or .WeaponEqpSlot > UserList(userindex).CurrentInventorySlots Then
140                         DummyInt = 1
142                     ElseIf .MunicionEqpSlot < 1 Or .MunicionEqpSlot > UserList(userindex).CurrentInventorySlots Then
144                         DummyInt = 1
146                     ElseIf .MunicionEqpObjIndex = 0 Then
148                         DummyInt = 1
150                     ElseIf ObjData(.WeaponEqpObjIndex).Proyectil <> 1 Then
152                         DummyInt = 2
154                     ElseIf ObjData(.MunicionEqpObjIndex).OBJType <> e_OBJType.otFlechas Then
156                         DummyInt = 1
158                     ElseIf .Object(.MunicionEqpSlot).amount < 1 Then
160                         DummyInt = 1

                        End If
                    
162                     If DummyInt <> 0 Then
164                         If DummyInt = 1 Then
166                             Call WriteConsoleMsg(userindex, "No ten�s municiones.", e_FontTypeNames.FONTTYPE_INFO)

                            End If
                        
168                         Call Desequipar(userindex, .MunicionEqpSlot)
170                         Call WriteWorkRequestTarget(userindex, 0)
                            Exit Sub

                        End If

                    End With
                
                    'Quitamos stamina
172                 If .Stats.MinSta >= 10 Then
174                     Call QuitarSta(userindex, RandomNumber(1, 10))
                    Else
180                     Call WriteLocaleMsg(userindex, "93", e_FontTypeNames.FONTTYPE_INFO)
                        ' Call WriteConsoleMsg(UserIndex, "Est�s muy cansado para luchar.", e_FontTypeNames.FONTTYPE_INFO)
182                     Call WriteWorkRequestTarget(userindex, 0)
                        Exit Sub

                    End If
                
184                 Call LookatTile(userindex, .Pos.Map, X, Y)
                
186                 tU = .flags.TargetUser
188                 tN = .flags.TargetNPC
190                 consumirMunicion = False

                    'Validate target
192                 If tU > 0 Then

                        'Only allow to atack if the other one can retaliate (can see us)
194                     If Abs(UserList(tU).Pos.Y - .Pos.Y) > RANGO_VISION_Y Then
196                         Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                            'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos para atacar.", e_FontTypeNames.FONTTYPE_WARNING)
198                         Call WriteWorkRequestTarget(userindex, 0)
                            Exit Sub

                        End If
                    
                        'Prevent from hitting self
200                     If tU = userindex Then
202                         Call WriteConsoleMsg(userindex, "�No pod�s atacarte a vos mismo!", e_FontTypeNames.FONTTYPE_INFO)
204                         Call WriteWorkRequestTarget(userindex, 0)
                            Exit Sub

                        End If
                    
                        'Attack!
206                     If Not PuedeAtacar(userindex, tU) Then Exit Sub 'TODO: Por ahora pongo esto para solucionar lo anterior.
                    
                        Dim backup    As Byte
                        Dim envie     As Boolean
                        Dim Particula As Integer
                        Dim Tiempo    As Long

                        ' Porque no es HandleAttack ???
208                     Call UsuarioAtacaUsuario(userindex, tU)

210                     If ObjData(.Invent.MunicionEqpObjIndex).CreaFX <> 0 Then
212                         Call SendData(SendTarget.ToPCArea, tU, PrepareMessageCreateFX(UserList(tU).Char.CharIndex, ObjData(.Invent.MunicionEqpObjIndex).CreaFX, 0))

                        End If
                        
                        'Si no es GM invisible, le envio el movimiento del arma.
                        If UserList(userindex).flags.AdminInvisible = 0 Then
                            Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageArmaMov(UserList(userindex).Char.CharIndex))
                        End If
                    
214                     If ObjData(.Invent.MunicionEqpObjIndex).CreaParticula <> "" Then
                    
216                         Particula = val(ReadField(1, ObjData(.Invent.MunicionEqpObjIndex).CreaParticula, Asc(":")))
218                         Tiempo = val(ReadField(2, ObjData(.Invent.MunicionEqpObjIndex).CreaParticula, Asc(":")))
220                         Call SendData(SendTarget.ToPCArea, tU, PrepareMessageParticleFX(UserList(tU).Char.CharIndex, Particula, Tiempo, False))

                        End If
                    
222                     consumirMunicion = True
                    
224                 ElseIf tN > 0 Then

                        'Only allow to atack if the other one can retaliate (can see us)
226                     If Abs(NpcList(tN).Pos.Y - .Pos.Y) > RANGO_VISION_Y And Abs(NpcList(tN).Pos.X - .Pos.X) > RANGO_VISION_X Then
228                         Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
230                         Call WriteWorkRequestTarget(userindex, 0)
                            'Call WriteConsoleMsg(UserIndex, "Estas demasiado lejos para atacar.", e_FontTypeNames.FONTTYPE_WARNING)
                            Exit Sub

                        End If
                    
                        'Is it attackable???
232                     If NpcList(tN).Attackable <> 0 Then
234                         If PuedeAtacarNPC(userindex, tN) Then
236                             Call UsuarioAtacaNpc(userindex, tN)
238                             consumirMunicion = True
                                'Si no es GM invisible, le envio el movimiento del arma.
                                If UserList(userindex).flags.AdminInvisible = 0 Then
                                    Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageArmaMov(UserList(userindex).Char.CharIndex))
                                End If
                            Else
240                             consumirMunicion = False

                            End If

                        End If

                    End If
                
242                 With .Invent
244                     DummyInt = .MunicionEqpSlot
                        
                        If DummyInt <> 0 Then
                        
                            'Take 1 arrow away - we do it AFTER hitting, since if Ammo Slot is 0 it gives a rt9 and kicks players
246                         If consumirMunicion Then
248                             Call QuitarUserInvItem(userindex, DummyInt, 1)
                            End If
                        
250                         If .Object(DummyInt).amount > 0 Then

                                'QuitarUserInvItem unequipps the ammo, so we equip it again
252                             .MunicionEqpSlot = DummyInt
254                             .MunicionEqpObjIndex = .Object(DummyInt).ObjIndex
256                             .Object(DummyInt).Equipped = 1
    
                            Else
258                             .MunicionEqpSlot = 0
260                             .MunicionEqpObjIndex = 0
    
                            End If
    
262                         Call UpdateUserInv(False, userindex, DummyInt)
                        
                        End If
                        
                    End With
                    '-----------------------------------
            
264             Case e_Skill.Magia
                    'Check the map allows spells to be casted.
                    '  If MapInfo(.Pos.map).MagiaSinEfecto > 0 Then
                    ' Call WriteConsoleMsg(UserIndex, "Una fuerza oscura te impide canalizar tu energ�a", e_FontTypeNames.FONTTYPE_FIGHT)
                    '  Exit Sub
                    ' End If
                
                    'Target whatever is in that tile
266                 Call LookatTile(userindex, .Pos.Map, X, Y)
                
                    'If it's outside range log it and exit
268                 If Abs(.Pos.X - X) > RANGO_VISION_X Or Abs(.Pos.Y - Y) > RANGO_VISION_Y Then
270                     Call LogSecurity("Ataque fuera de rango de " & .name & "(" & .Pos.Map & "/" & .Pos.X & "/" & .Pos.Y & ") ip: " & .IP & " a la posicion (" & .Pos.Map & "/" & X & "/" & Y & ")")
                        Exit Sub

                    End If
                
                    'Check bow's interval
272                 If Not IntervaloPermiteUsarArcos(userindex, False) Then Exit Sub
                
                    'Check attack-spell interval
274                 If Not IntervaloPermiteGolpeMagia(userindex, False) Then Exit Sub
                
                    'Check Magic interval
276                 If Not IntervaloPermiteLanzarSpell(userindex) Then Exit Sub
                
                    'Check intervals and cast
278                 If .flags.Hechizo > 0 Then
280                     Call LanzarHechizo(.flags.Hechizo, userindex)
282                     .flags.Hechizo = 0
                    Else
284                     Call WriteConsoleMsg(userindex, "�Primero selecciona el hechizo que quieres lanzar!", e_FontTypeNames.FONTTYPE_INFO)

                    End If
            
286             Case e_Skill.Pescar
                    If .Counters.Trabajando = 0 Then
                        Call Trabajar(userindex, e_Skill.Pescar)
                    End If
348             Case e_Skill.Talar
                    If .Counters.Trabajando = 0 Then
                        Call Trabajar(userindex, e_Skill.Talar)
                    End If
                    
400             Case e_Skill.Alquimia
            
402                 If .Invent.HerramientaEqpObjIndex = 0 Then Exit Sub
                    
404                 If ObjData(.Invent.HerramientaEqpObjIndex).OBJType <> e_OBJType.otHerramientas Then Exit Sub
                    
                    'Check interval
406                 If Not IntervaloPermiteTrabajarExtraer(userindex) Then Exit Sub

408                 Select Case ObjData(.Invent.HerramientaEqpObjIndex).Subtipo
                
                        Case 3  ' Herramientas de Alquimia - Tijeras

410                         If MapInfo(UserList(userindex).Pos.Map).Seguro = 1 Then
412                             Call WriteWorkRequestTarget(userindex, 0)
414                             Call WriteConsoleMsg(userindex, "Esta prohibido cortar raices en las ciudades.", e_FontTypeNames.FONTTYPE_INFO)
                                Exit Sub

                            End If
                            
416                         If MapData(.Pos.Map, X, Y).ObjInfo.amount <= 0 Then
418                             Call WriteConsoleMsg(userindex, "El �rbol ya no te puede entregar mas raices.", e_FontTypeNames.FONTTYPE_INFO)
420                             Call WriteWorkRequestTarget(userindex, 0)
422                             Call WriteMacroTrabajoToggle(userindex, False)
                                Exit Sub

                            End If
                
424                         DummyInt = MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex
                            
426                         If DummyInt > 0 Then
                            
428                             If Abs(.Pos.X - X) + Abs(.Pos.Y - Y) > 2 Then
430                                 Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                                    'Call WriteConsoleMsg(UserIndex, "Estas demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
432                                 Call WriteWorkRequestTarget(userindex, 0)
                                    Exit Sub

                                End If
                                
434                             If .Pos.X = X And .Pos.Y = Y Then
436                                 Call WriteConsoleMsg(userindex, "No pod�s quitar raices all�.", e_FontTypeNames.FONTTYPE_INFO)
438                                 Call WriteWorkRequestTarget(userindex, 0)
                                    Exit Sub

                                End If
                                
                                '�Hay un arbol donde clickeo?
440                             If ObjData(DummyInt).OBJType = e_OBJType.otArboles Then
442                                 Call SendData(SendTarget.ToPCArea, userindex, PrepareMessagePlayWave(SND_TIJERAS, .Pos.X, .Pos.Y))
444                                 Call DoRaices(userindex, X, Y)

                                End If

                            Else
446                             Call WriteConsoleMsg(userindex, "No hay ning�n �rbol ah�.", e_FontTypeNames.FONTTYPE_INFO)
448                             Call WriteWorkRequestTarget(userindex, 0)
450                             Call WriteMacroTrabajoToggle(userindex, False)

                            End If
                
                    End Select
                
452             Case e_Skill.Mineria
                    If .Counters.Trabajando = 0 Then
                        Call Trabajar(userindex, e_Skill.Mineria)
                    End If
500             Case e_Skill.Robar

                    'Does the map allow us to steal here?
502                 If MapInfo(.Pos.Map).Seguro = 0 Then
                    
                        'Check interval
504                     If Not IntervaloPermiteTrabajarExtraer(userindex) Then Exit Sub
                    
                        'Target whatever is in that tile
506                     Call LookatTile(userindex, UserList(userindex).Pos.Map, X, Y)
                    
508                     tU = .flags.TargetUser
                    
510                     If tU > 0 And tU <> userindex Then

                            'Can't steal administrative players
512                         If UserList(tU).flags.Privilegios And e_PlayerType.user Then
514                             If UserList(tU).flags.Muerto = 0 Then
                                    Dim DistanciaMaxima As Integer

516                                 If .clase = e_Class.Thief Then
518                                     DistanciaMaxima = 2
                                    Else
520                                     DistanciaMaxima = 1

                                    End If

522                                 If Abs(.Pos.X - UserList(tU).Pos.X) + Abs(.Pos.Y - UserList(tU).Pos.Y) > DistanciaMaxima Then
524                                     Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                                        'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
526                                     Call WriteWorkRequestTarget(userindex, 0)
                                        Exit Sub

                                    End If
                                 
                                    '17/09/02
                                    'Check the trigger
528                                 If MapData(UserList(tU).Pos.Map, UserList(tU).Pos.X, UserList(tU).Pos.Y).trigger = e_Trigger.ZonaSegura Then
530                                     Call WriteConsoleMsg(userindex, "No pod�s robar aqu�.", e_FontTypeNames.FONTTYPE_WARNING)
532                                     Call WriteWorkRequestTarget(userindex, 0)
                                        Exit Sub

                                    End If
                                 
534                                 If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = e_Trigger.ZonaSegura Then
536                                     Call WriteConsoleMsg(userindex, "No pod�s robar aqu�.", e_FontTypeNames.FONTTYPE_WARNING)
538                                     Call WriteWorkRequestTarget(userindex, 0)
                                        Exit Sub

                                    End If
                                 
540                                 Call DoRobar(userindex, tU)

                                End If

                            End If

                        Else
542                         Call WriteConsoleMsg(userindex, "No a quien robarle!", e_FontTypeNames.FONTTYPE_INFO)
544                         Call WriteWorkRequestTarget(userindex, 0)

                        End If

                    Else
546                     Call WriteConsoleMsg(userindex, "�No pod�s robar en zonas seguras!", e_FontTypeNames.FONTTYPE_INFO)
548                     Call WriteWorkRequestTarget(userindex, 0)

                    End If
                    
550             Case e_Skill.Domar
                    'Modificado 25/11/02
                    'Optimizado y solucionado el bug de la doma de criaturas hostiles.
                    
                    'Target whatever is that tile
552                 Call LookatTile(userindex, .Pos.Map, X, Y)
554                 tN = .flags.TargetNPC
                    
556                 If tN > 0 Then
558                     If NpcList(tN).flags.Domable > 0 Then
560                         If Abs(.Pos.X - X) + Abs(.Pos.Y - Y) > 4 Then
562                             Call WriteConsoleMsg(userindex, "Estas demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                                Exit Sub
    
                            End If
                            
564                         If LenB(NpcList(tN).flags.AttackedBy) <> 0 Then
566                             Call WriteConsoleMsg(userindex, "No puedes domar una criatura que esta luchando con un jugador.", e_FontTypeNames.FONTTYPE_INFO)
                                Exit Sub
    
                            End If
                            
568                         Call DoDomar(userindex, tN)
                        Else
570                         Call WriteConsoleMsg(userindex, "No puedes domar a esa criatura.", e_FontTypeNames.FONTTYPE_INFO)
    
                        End If
    
                    Else
572                     Call WriteConsoleMsg(userindex, "No hay ninguna criatura alli!", e_FontTypeNames.FONTTYPE_INFO)
    
                    End If
               
574             Case FundirMetal    'UGLY!!! This is a constant, not a skill!!
            
                    'Check interval
576                 If Not IntervaloPermiteTrabajarConstruir(userindex) Then Exit Sub
                
578                 Call LookatTile(userindex, .Pos.Map, X, Y)
                
                    'Check there is a proper item there
580                 If .flags.TargetObj > 0 Then
582                     If ObjData(.flags.TargetObj).OBJType = e_OBJType.otFragua Then

                            'Validate other items
584                         If .flags.TargetObjInvSlot < 1 Or .flags.TargetObjInvSlot > UserList(userindex).CurrentInventorySlots Then
                                Exit Sub

                            End If
                        
                            ''chequeamos que no se zarpe duplicando oro
586                         If .Invent.Object(.flags.TargetObjInvSlot).ObjIndex <> .flags.TargetObjInvIndex Then
588                             If .Invent.Object(.flags.TargetObjInvSlot).ObjIndex = 0 Or .Invent.Object(.flags.TargetObjInvSlot).amount = 0 Then
590                                 Call WriteConsoleMsg(userindex, "No tienes m�s minerales", e_FontTypeNames.FONTTYPE_INFO)
592                                 Call WriteWorkRequestTarget(userindex, 0)
                                    Exit Sub

                                End If
                            
                                ''FUISTE
594                             Call WriteShowMessageBox(userindex, "Has sido expulsado por el sistema anti cheats.")
                            
596                             Call CloseSocket(userindex)
                                Exit Sub

                            End If
                        
598                         Call FundirMineral(userindex)
                        
                        Else
                    
600                         Call WriteConsoleMsg(userindex, "Ah� no hay ninguna fragua.", e_FontTypeNames.FONTTYPE_INFO)
602                         Call WriteWorkRequestTarget(userindex, 0)

604                         If UserList(userindex).Counters.Trabajando > 1 Then
606                             Call WriteMacroTrabajoToggle(userindex, False)

                            End If

                        End If

                    Else
                
608                     Call WriteConsoleMsg(userindex, "Ah� no hay ninguna fragua.", e_FontTypeNames.FONTTYPE_INFO)
610                     Call WriteWorkRequestTarget(userindex, 0)

612                     If UserList(userindex).Counters.Trabajando > 1 Then
614                         Call WriteMacroTrabajoToggle(userindex, False)

                        End If

                    End If

616             Case e_Skill.Grupo
                    'If UserList(UserIndex).Grupo.EnGrupo = False Then
                    'Target whatever is in that tile
                    'Call LookatTile(UserIndex, UserList(UserIndex).Pos.Map, X, Y)
                    
618                 tU = .flags.TargetUser
                    
                    'Call WritePreguntaBox(UserIndex, UserList(UserIndex).name & " te invit� a unirte a su grupo. �Deseas unirte?")
                    
620                 If tU > 0 And tU <> userindex Then

                        'Can't steal administrative players
622                     If UserList(userindex).Grupo.EnGrupo = False Then
624                         If UserList(tU).flags.Muerto = 0 Then
626                             If Abs(.Pos.X - X) + Abs(.Pos.Y - Y) > 8 Then
628                                 Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                                    'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
630                                 Call WriteWorkRequestTarget(userindex, 0)
                                    Exit Sub

                                End If
                                         
632                             If UserList(userindex).Grupo.CantidadMiembros = 0 Then
634                                 UserList(userindex).Grupo.Lider = userindex
636                                 UserList(userindex).Grupo.Miembros(1) = userindex
638                                 UserList(userindex).Grupo.CantidadMiembros = 1
640                                 Call InvitarMiembro(userindex, tU)
                                Else
642                                 UserList(userindex).Grupo.Lider = userindex
644                                 Call InvitarMiembro(userindex, tU)

                                End If
                                         
                            Else
646                             Call WriteLocaleMsg(userindex, "7", e_FontTypeNames.FONTTYPE_INFO)
                                'Call WriteConsoleMsg(UserIndex, "El usuario esta muerto.", e_FontTypeNames.FONTTYPE_INFOIAO)
648                             Call WriteWorkRequestTarget(userindex, 0)

                            End If

                        Else

650                         If UserList(userindex).Grupo.Lider = userindex Then
652                             Call InvitarMiembro(userindex, tU)
                            Else
654                             Call WriteConsoleMsg(userindex, "Tu no pod�s invitar usuarios, debe hacerlo " & UserList(UserList(userindex).Grupo.Lider).name & ".", e_FontTypeNames.FONTTYPE_INFOIAO)
656                             Call WriteWorkRequestTarget(userindex, 0)

                            End If

                        End If

                    Else
658                     Call WriteLocaleMsg(userindex, "261", e_FontTypeNames.FONTTYPE_INFO)

                    End If

                    ' End If
660             Case e_Skill.MarcaDeClan

                    'If UserList(UserIndex).Grupo.EnGrupo = False Then
                    'Target whatever is in that tile
                    Dim clan_nivel As Byte
                
662                 If UserList(userindex).GuildIndex = 0 Then
664                     Call WriteConsoleMsg(userindex, "Servidor � No perteneces a ning�n clan.", e_FontTypeNames.FONTTYPE_INFOIAO)
                        Exit Sub
                    End If
                
666                 clan_nivel = modGuilds.NivelDeClan(UserList(userindex).GuildIndex)

668                 If clan_nivel < 3 Then
670                     Call WriteConsoleMsg(userindex, "Servidor � El nivel de tu clan debe ser 3 para utilizar esta opci�n.", e_FontTypeNames.FONTTYPE_INFOIAO)
                        Exit Sub
                    End If
                                
672                 Call LookatTile(userindex, UserList(userindex).Pos.Map, X, Y)
                    
674                 tU = .flags.TargetUser

676                 If tU = 0 Then Exit Sub
                    
678                 If UserList(userindex).GuildIndex = UserList(tU).GuildIndex Then
680                     Call WriteConsoleMsg(userindex, "Servidor � No podes marcar a un miembro de tu clan.", e_FontTypeNames.FONTTYPE_INFOIAO)
                        Exit Sub

                    End If
                    
                    'Call WritePreguntaBox(UserIndex, UserList(UserIndex).name & " te invit� a unirte a su grupo. �Deseas unirte?")
                    
682                 If tU > 0 And tU <> userindex Then

                        ' WyroX: No puede marcar admins invisibles
684                     If UserList(tU).flags.AdminInvisible <> 0 Then Exit Sub

                        'Can't steal administrative players
686                     If UserList(tU).flags.Muerto = 0 Then

                            'call marcar
688                         If UserList(tU).flags.invisible = 1 Or UserList(tU).flags.Oculto = 1 Then
690                             Call SendData(SendTarget.ToClanArea, userindex, PrepareMessageParticleFX(UserList(tU).Char.CharIndex, 210, 50, False))
                            Else
692                             Call SendData(SendTarget.ToClanArea, userindex, PrepareMessageParticleFX(UserList(tU).Char.CharIndex, 210, 150, False))

                            End If

694                         Call SendData(SendTarget.ToClanArea, userindex, PrepareMessageConsoleMsg("Clan> [" & UserList(userindex).name & "] marco a " & UserList(tU).name & ".", e_FontTypeNames.FONTTYPE_GUILD))
                        Else
696                         Call WriteLocaleMsg(userindex, "7", e_FontTypeNames.FONTTYPE_INFO)
                            'Call WriteConsoleMsg(UserIndex, "El usuario esta muerto.", e_FontTypeNames.FONTTYPE_INFOIAO)
698                         Call WriteWorkRequestTarget(userindex, 0)

                        End If

                    Else
700                     Call WriteLocaleMsg(userindex, "261", e_FontTypeNames.FONTTYPE_INFO)

                    End If

702             Case e_Skill.MarcaDeGM
704                 Call LookatTile(userindex, UserList(userindex).Pos.Map, X, Y)
                    
706                 tU = .flags.TargetUser

708                 If tU > 0 Then
710                     Call WriteConsoleMsg(userindex, "Servidor � [" & UserList(tU).name & "] seleccionado.", e_FontTypeNames.FONTTYPE_SERVER)
                    Else
712                     Call WriteLocaleMsg(userindex, "261", e_FontTypeNames.FONTTYPE_INFO)

                    End If
                    
            End Select

        End With
        
        Exit Sub

HandleWorkLeftClick_Err:
714     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWorkLeftClick", Erl)
716
        
End Sub

''
' Handles the "CreateNewGuild" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCreateNewGuild(ByVal userindex As Integer)

    '***************************************************
    'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
    'Last Modification: 05/17/06
    '
    '***************************************************

    On Error GoTo ErrHandler

100 With UserList(userindex)
        
        Dim Desc       As String
        Dim GuildName  As String
        Dim errorStr   As String
        Dim Alineacion As Byte
        
102     Desc = Reader.ReadString8()
104     GuildName = Reader.ReadString8()
106     Alineacion = Reader.ReadInt()
        
108     If modGuilds.CrearNuevoClan(userindex, Desc, GuildName, Alineacion, errorStr) Then

110         Call QuitarObjetos(407, 1, userindex)
112         Call QuitarObjetos(408, 1, userindex)
114         Call QuitarObjetos(409, 1, userindex)
116         Call QuitarObjetos(411, 1, userindex)
            
            
                
118             Call SendData(SendTarget.ToAll, userindex, PrepareMessageConsoleMsg(.name & " ha fundado el clan <" & GuildName & "> de alineaci�n " & GuildAlignment(.GuildIndex) & ".", e_FontTypeNames.FONTTYPE_GUILD))
120             Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayWave(44, NO_3D_SOUND, NO_3D_SOUND))
                'Update tag
122             Call RefreshCharStatus(userindex)
            Else
124             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

        End If

    End With
        
    Exit Sub
        
ErrHandler:

126 Call TraceError(Err.Number, Err.Description, "Protocol.HandleCreateNewGuild", Erl)
128

End Sub

''
' Handles the "SpellInfo" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSpellInfo(ByVal userindex As Integer)
        
        On Error GoTo HandleSpellInfo_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)
        
            Dim spellSlot As Byte
            Dim Spell     As Integer
        
102         spellSlot = Reader.ReadInt()
        
            'Validate slot
104         If spellSlot < 1 Or spellSlot > MAXUSERHECHIZOS Then
106             Call WriteConsoleMsg(userindex, "�Primero selecciona el hechizo!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate spell in the slot
108         Spell = .Stats.UserHechizos(spellSlot)

110         If Spell > 0 And Spell < NumeroHechizos + 1 Then

112             With Hechizos(Spell)
                    'Send information
114                 Call WriteConsoleMsg(userindex, "HECINF*" & Spell, e_FontTypeNames.FONTTYPE_INFO)

                End With

            End If

        End With
        
        Exit Sub

HandleSpellInfo_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSpellInfo", Erl)
118
        
End Sub

''
' Handles the "EquipItem" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleEquipItem(ByVal userindex As Integer)
        
        On Error GoTo HandleEquipItem_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
100     With UserList(userindex)
        
            Dim itemSlot As Byte
102         itemSlot = Reader.ReadInt()
                
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.EquipItem
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "EquipItem", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
            
            'Dead users can't equip items
104         If .flags.Muerto = 1 Then
106             Call WriteConsoleMsg(userindex, "��Est�s muerto!! S�lo pod�s usar items cuando est�s vivo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate item slot
108         If itemSlot > UserList(userindex).CurrentInventorySlots Or itemSlot < 1 Then Exit Sub
        
110         If .Invent.Object(itemSlot).ObjIndex = 0 Then Exit Sub
        
112         Call EquiparInvItem(userindex, itemSlot)

        End With
        
        Exit Sub

HandleEquipItem_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleEquipItem", Erl)
116
        
End Sub

''
' Handles the "Change_Heading" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleChange_Heading(ByVal userindex As Integer)
        
        On Error GoTo HandleChange_Heading_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 10/01/08
        'Last Modified By: Lucas Tavolaro Ortiz (Tavo)
        ' 10/01/2008: Tavo - Se cancela la salida del juego si el user esta saliendo
        '***************************************************
    
100     With UserList(userindex)
        
            Dim Heading As e_Heading
102             Heading = Reader.ReadInt()
                            
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.ChangeHeading
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "ChangeHeading", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
        
            'Validate heading (VB won't say invalid cast if not a valid index like .Net languages would do... *sigh*)
104         If Heading > 0 And Heading < 5 Then
106             .Char.Heading = Heading
108             Call ChangeUserChar(userindex, .Char.Body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)

            End If

        End With

        Exit Sub

HandleChange_Heading_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChange_Heading", Erl)
112
        
End Sub

''
' Handles the "ModifySkills" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleModifySkills(ByVal userindex As Integer)
        
        On Error GoTo HandleModifySkills_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim i                      As Long
            Dim Count                  As Integer
            Dim points(1 To NUMSKILLS) As Byte
        
            'Codigo para prevenir el hackeo de los skills
            '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
102         For i = 1 To NUMSKILLS
104             points(i) = Reader.ReadInt()
            
106             If points(i) < 0 Then
108                 Call LogSecurity(.name & " IP:" & .IP & " trat� de hackear los skills.")
110                 .Stats.SkillPts = 0
112                 Call CloseSocket(userindex)
                    Exit Sub

                End If
            
114             Count = Count + points(i)
116         Next i
        
118         If Count > .Stats.SkillPts Then
120             Call LogSecurity(.name & " IP:" & .IP & " trat� de hackear los skills.")
122             Call CloseSocket(userindex)
                Exit Sub

            End If

            '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        
124         With .Stats

126             For i = 1 To NUMSKILLS
128                 .SkillPts = .SkillPts - points(i)
                    
                    If .UserSkills(i) <> .UserSkills(i) + points(i) Then
130                     .UserSkills(i) = .UserSkills(i) + points(i)
                    
                        'Client should prevent this, but just in case...
132                     If .UserSkills(i) > 100 Then
134                         .SkillPts = .SkillPts + .UserSkills(i) - 100
136                         .UserSkills(i) = 100
                        End If
                        
                        UserList(userindex).flags.ModificoSkills = True
                    End If
138             Next i

            End With

        End With
        
        Exit Sub

HandleModifySkills_Err:
140     Call TraceError(Err.Number, Err.Description, "Protocol.HandleModifySkills", Erl)
142
        
End Sub

''
' Handles the "Train" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleTrain(ByVal userindex As Integer)
        
        On Error GoTo HandleTrain_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
100     With UserList(userindex)
        
            Dim SpawnedNpc As Integer
            Dim PetIndex   As Byte
        
102         PetIndex = Reader.ReadInt()
        
104         If .flags.TargetNPC = 0 Then Exit Sub
        
106         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Entrenador Then Exit Sub
        
108         If NpcList(.flags.TargetNPC).Mascotas < MAXMASCOTASENTRENADOR Then
        
110             If PetIndex > 0 And PetIndex < NpcList(.flags.TargetNPC).NroCriaturas + 1 Then
                    'Create the creature
112                 SpawnedNpc = SpawnNpc(NpcList(.flags.TargetNPC).Criaturas(PetIndex).NpcIndex, NpcList(.flags.TargetNPC).Pos, True, False)
                
114                 If SpawnedNpc > 0 Then
116                     NpcList(SpawnedNpc).MaestroNPC = .flags.TargetNPC
118                     NpcList(.flags.TargetNPC).Mascotas = NpcList(.flags.TargetNPC).Mascotas + 1

                    End If

                End If

            Else
120             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageChatOverHead("No puedo traer m�s criaturas, mata las existentes!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite))

            End If

        End With
        
        Exit Sub

HandleTrain_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTrain", Erl)
124
        
End Sub

''
' Handles the "CommerceBuy" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCommerceBuy(ByVal userindex As Integer)
        
        On Error GoTo HandleCommerceBuy_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
100     With UserList(userindex)
        
            Dim Slot   As Byte
            Dim amount As Integer
        
102         Slot = Reader.ReadInt()
104         amount = Reader.ReadInt()
        
            'Dead people can't commerce...
106         If .flags.Muerto = 1 Then
108             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'El target es un NPC valido?
110         If .flags.TargetNPC < 1 Then Exit Sub
            
            '�El NPC puede comerciar?
112         If NpcList(.flags.TargetNPC).Comercia = 0 Then
114             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageChatOverHead("No tengo ning�n inter�s en comerciar.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite))
                Exit Sub

            End If
        
            'Only if in commerce mode....
116         If Not .flags.Comerciando Then
118             Call WriteConsoleMsg(userindex, "No est�s comerciando", e_FontTypeNames.FONTTYPE_INFO)
120             Call WriteCommerceEnd(userindex)
                Exit Sub

            End If
        
            'User compra el item
122         Call Comercio(eModoComercio.Compra, userindex, .flags.TargetNPC, Slot, amount)

        End With

        Exit Sub

HandleCommerceBuy_Err:
124     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCommerceBuy", Erl)
126
        
End Sub

''
' Handles the "BankExtractItem" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBankExtractItem(ByVal userindex As Integer)
        
        On Error GoTo HandleBankExtractItem_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim Slot        As Byte
            Dim slotdestino As Byte
            Dim amount      As Integer
        
102         Slot = Reader.ReadInt()
104         amount = Reader.ReadInt()
106         slotdestino = Reader.ReadInt()
        
            'Dead people can't commerce
108         If .flags.Muerto = 1 Then
110             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            '�El target es un NPC valido?
112         If .flags.TargetNPC < 1 Then Exit Sub
        
            '�Es el banquero?
114         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Banquero Then Exit Sub

            'User retira el item del slot
116         Call UserRetiraItem(userindex, Slot, amount, slotdestino)

        End With

        Exit Sub

HandleBankExtractItem_Err:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBankExtractItem", Erl)
120
        
End Sub

''
' Handles the "CommerceSell" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCommerceSell(ByVal userindex As Integer)
        
        On Error GoTo HandleCommerceSell_Err
        
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
100     With UserList(userindex)

            Dim Slot   As Byte
            Dim amount As Integer
        
102         Slot = Reader.ReadInt()
104         amount = Reader.ReadInt()
        
            'Dead people can't commerce...
106         If .flags.Muerto = 1 Then
108             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            '�El target es un NPC valido?
110         If .flags.TargetNPC < 1 Then Exit Sub
        
            '�El NPC puede comerciar?
112         If NpcList(.flags.TargetNPC).Comercia = 0 Then
114             Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageChatOverHead("No tengo ning�n inter�s en comerciar.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite))
                Exit Sub

            End If
        
            'User compra el item del slot
116         Call Comercio(eModoComercio.Venta, userindex, .flags.TargetNPC, Slot, amount)

        End With

        Exit Sub

HandleCommerceSell_Err:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCommerceSell", Erl)
120
        
End Sub

''
' Handles the "BankDeposit" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBankDeposit(ByVal userindex As Integer)
        
        On Error GoTo HandleBankDeposit_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
100     With UserList(userindex)
        
            Dim Slot        As Byte
            Dim slotdestino As Byte
            Dim amount      As Integer
        
102         Slot = Reader.ReadInt()
104         amount = Reader.ReadInt()
106         slotdestino = Reader.ReadInt()
        
            'Dead people can't commerce...
108         If .flags.Muerto = 1 Then
110             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            '�El target es un NPC valido?
112         If .flags.TargetNPC < 1 Then Exit Sub
        
            '�El NPC puede comerciar?
114         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Banquero Then
                Exit Sub

            End If
            
116         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 10 Then
118             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'User deposita el item del slot rdata
120         Call UserDepositaItem(userindex, Slot, amount, slotdestino)

        End With
        
        Exit Sub

HandleBankDeposit_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBankDeposit", Erl)
124
        
End Sub

''
' Handles the "ForumPost" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleForumPost(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim File     As String
            Dim title    As String
            Dim Msg      As String
            Dim postFile As String
            Dim handle   As Integer
            Dim i        As Long
            Dim Count    As Integer
        
102         title = Reader.ReadString8()
104         Msg = Reader.ReadString8()
        
106         If .flags.TargetObj > 0 Then
108             File = App.Path & "\foros\" & UCase$(ObjData(.flags.TargetObj).ForoID) & ".for"
            
110             If FileExist(File, vbNormal) Then
112                 Count = val(GetVar(File, "INFO", "CantMSG"))
                
                    'If there are too many messages, delete the forum
114                 If Count > MAX_MENSAJES_FORO Then

116                     For i = 1 To Count
118                         Kill App.Path & "\foros\" & UCase$(ObjData(.flags.TargetObj).ForoID) & i & ".for"
120                     Next i

122                     Kill App.Path & "\foros\" & UCase$(ObjData(.flags.TargetObj).ForoID) & ".for"
124                     Count = 0

                    End If

                Else
                    'Starting the forum....
126                 Count = 0

                End If
            
128             handle = FreeFile()
130             postFile = Left$(File, Len(File) - 4) & CStr(Count + 1) & ".for"
            
                'Create file
132             Open postFile For Output As handle
134             Print #handle, title
136             Print #handle, Msg
138             Close #handle
            
                'Update post count
140             Call WriteVar(File, "INFO", "CantMSG", Count + 1)

            End If

        End With
        
        Exit Sub
        
ErrHandler:
142     Close #handle
144     Call TraceError(Err.Number, Err.Description, "Protocol.HandleForumPost", Erl)
146

End Sub

''
' Handles the "MoveSpell" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleMoveSpell(ByVal userindex As Integer)
        
        On Error GoTo HandleMoveSpell_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

            Dim dir As Integer
        
102         If Reader.ReadBool() Then
104             dir = 1
            Else
106             dir = -1

            End If
        
108         Call DesplazarHechizo(userindex, dir, Reader.ReadInt())

        Exit Sub

HandleMoveSpell_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMoveSpell", Erl)
112
        
End Sub

''
' Handles the "ClanCodexUpdate" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleClanCodexUpdate(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Desc As String
        
102         Desc = Reader.ReadString8()
        
104         Call modGuilds.ChangeCodexAndDesc(Desc, .GuildIndex)

        End With
        
        Exit Sub
        
ErrHandler:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMoveSpell", Erl)
108

End Sub

''
' Handles the "UserCommerceOffer" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUserCommerceOffer(ByVal userindex As Integer)
        
        On Error GoTo HandleUserCommerceOffer_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
100     With UserList(userindex)

            Dim tUser  As Integer
            Dim Slot   As Byte
            Dim amount As Long
            
102         Slot = Reader.ReadInt()
104         amount = Reader.ReadInt()
        
            'Get the other player
106         tUser = .ComUsu.DestUsu
        
            'If Amount is invalid, or slot is invalid and it's not gold, then ignore it.
108         If ((Slot < 1 Or Slot > UserList(userindex).CurrentInventorySlots) And Slot <> FLAGORO) Or amount <= 0 Then Exit Sub
        
            'Is the other player valid??
110         If tUser < 1 Or tUser > MaxUsers Then Exit Sub
        
            'Is the commerce attempt valid??
112         If UserList(tUser).ComUsu.DestUsu <> userindex Then
114             Call FinComerciarUsu(userindex)
                Exit Sub

            End If
        
            'Is he still logged??
116         If Not UserList(tUser).flags.UserLogged Then
118             Call FinComerciarUsu(userindex)
                Exit Sub
            Else

                'Is he alive??
120             If UserList(tUser).flags.Muerto = 1 Then
122                 Call FinComerciarUsu(userindex)
                    Exit Sub

                End If
            
                'Has he got enough??
124             If Slot = FLAGORO Then

                    'gold
126                 If amount > .Stats.GLD Then
128                     Call WriteConsoleMsg(userindex, "No tienes esa cantidad.", e_FontTypeNames.FONTTYPE_TALK)
                        Exit Sub

                    End If

                Else

                    'inventory
130                 If amount > .Invent.Object(Slot).amount Then
132                     Call WriteConsoleMsg(userindex, "No tienes esa cantidad.", e_FontTypeNames.FONTTYPE_TALK)
                        Exit Sub

                    End If
                
134                 If .Invent.Object(Slot).ObjIndex > 0 Then
136                     If ObjData(.Invent.Object(Slot).ObjIndex).Instransferible = 1 Then
138                         Call WriteConsoleMsg(userindex, "Este objeto es intransferible, no pod�s venderlo.", e_FontTypeNames.FONTTYPE_TALK)
                            Exit Sub
    
                        End If
                    
140                     If ObjData(.Invent.Object(Slot).ObjIndex).Newbie = 1 Then
142                         Call WriteConsoleMsg(userindex, "No puedes comerciar objetos newbie.", e_FontTypeNames.FONTTYPE_TALK)
                            Exit Sub
                        End If
    
                    End If

                End If
            
                'Prevent offer changes (otherwise people would ripp off other players)
                'If .ComUsu.Objeto > 0 Then
                '     Call WriteConsoleMsg(UserIndex, "No pod�s cambiar tu oferta.", e_FontTypeNames.FONTTYPE_TALK)
                '     Exit Sub

                '  End If
            
                'Don't allow to sell boats if they are equipped (you can't take them off in the water and causes trouble)
144             If .flags.Navegando = 1 Then
146                 If .Invent.BarcoSlot = Slot Then
148                     Call WriteConsoleMsg(userindex, "No pod�s vender tu barco mientras lo est�s usando.", e_FontTypeNames.FONTTYPE_TALK)
                        Exit Sub

                    End If

                End If
            
150             If .flags.Montado = 1 Then
152                 If .Invent.MonturaSlot = Slot Then
154                     Call WriteConsoleMsg(userindex, "No pod�s vender tu montura mientras la est�s usando.", e_FontTypeNames.FONTTYPE_TALK)
                        Exit Sub

                    End If

                End If
            
156             .ComUsu.Objeto = Slot
158             .ComUsu.cant = amount
            
                'If the other one had accepted, we turn that back and inform of the new offer (just to be cautious).
160             If UserList(tUser).ComUsu.Acepto Then
162                 UserList(tUser).ComUsu.Acepto = False
164                 Call WriteConsoleMsg(tUser, .name & " ha cambiado su oferta.", e_FontTypeNames.FONTTYPE_TALK)

                End If
            
                Dim ObjAEnviar As t_Obj
                
166             ObjAEnviar.amount = amount

                'Si no es oro tmb le agrego el objInex
168             If Slot <> FLAGORO Then ObjAEnviar.ObjIndex = UserList(userindex).Invent.Object(Slot).ObjIndex
                'Llamos a la funcion
170             Call EnviarObjetoTransaccion(tUser, userindex, ObjAEnviar)

            End If

        End With

        Exit Sub

HandleUserCommerceOffer_Err:
172     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUserCommerceOffer", Erl)
174
        
End Sub

''
' Handles the "GuildAcceptPeace" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildAcceptPeace(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild          As String
            Dim errorStr       As String
            Dim otherClanIndex As String
        
102         guild = Reader.ReadString8()
        
104         otherClanIndex = modGuilds.r_AceptarPropuestaDePaz(userindex, guild, errorStr)
        
106         If otherClanIndex = 0 Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)
            Else
110             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Tu clan ha firmado la paz con " & guild, e_FontTypeNames.FONTTYPE_GUILD))
112             Call SendData(SendTarget.ToGuildMembers, otherClanIndex, PrepareMessageConsoleMsg("Tu clan ha firmado la paz con " & modGuilds.GuildName(.GuildIndex), e_FontTypeNames.FONTTYPE_GUILD))

            End If

        End With
        
        Exit Sub

ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildAcceptPeace", Erl)
116

End Sub

''
' Handles the "GuildRejectAlliance" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildRejectAlliance(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild          As String
            Dim errorStr       As String
            Dim otherClanIndex As String
        
102         guild = Reader.ReadString8()
        
104         otherClanIndex = modGuilds.r_RechazarPropuestaDeAlianza(userindex, guild, errorStr)
        
106         If otherClanIndex = 0 Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            Else
110             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Tu clan rechazado la propuesta de alianza de " & guild, e_FontTypeNames.FONTTYPE_GUILD))
112             Call SendData(SendTarget.ToGuildMembers, otherClanIndex, PrepareMessageConsoleMsg(modGuilds.GuildName(.GuildIndex) & " ha rechazado nuestra propuesta de alianza con su clan.", e_FontTypeNames.FONTTYPE_GUILD))

            End If

        End With
        
        Exit Sub
        
ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildRejectAlliance", Erl)
116

End Sub

''
' Handles the "GuildRejectPeace" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildRejectPeace(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild          As String
            Dim errorStr       As String
            Dim otherClanIndex As String
        
102         guild = Reader.ReadString8()
        
104         otherClanIndex = modGuilds.r_RechazarPropuestaDePaz(userindex, guild, errorStr)
        
106         If otherClanIndex = 0 Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            Else
110             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Tu clan rechazado la propuesta de paz de " & guild, e_FontTypeNames.FONTTYPE_GUILD))
112             Call SendData(SendTarget.ToGuildMembers, otherClanIndex, PrepareMessageConsoleMsg(modGuilds.GuildName(.GuildIndex) & " ha rechazado nuestra propuesta de paz con su clan.", e_FontTypeNames.FONTTYPE_GUILD))

            End If

        End With
        
        Exit Sub
        
ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildRejectPeace", Erl)
116

End Sub

''
' Handles the "GuildAcceptAlliance" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildAcceptAlliance(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild          As String
            Dim errorStr       As String
            Dim otherClanIndex As String
        
102         guild = Reader.ReadString8()
        
104         otherClanIndex = modGuilds.r_AceptarPropuestaDeAlianza(userindex, guild, errorStr)
        
106         If otherClanIndex = 0 Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            Else
110             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Tu clan ha firmado la alianza con " & guild, e_FontTypeNames.FONTTYPE_GUILD))
112             Call SendData(SendTarget.ToGuildMembers, otherClanIndex, PrepareMessageConsoleMsg("Tu clan ha firmado la paz con " & modGuilds.GuildName(.GuildIndex), e_FontTypeNames.FONTTYPE_GUILD))

            End If

        End With
        
        Exit Sub
        
ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildAcceptAlliance", Erl)
116

End Sub

''
' Handles the "GuildOfferPeace" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildOfferPeace(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild    As String
            Dim proposal As String
            Dim errorStr As String
        
102         guild = Reader.ReadString8()
104         proposal = Reader.ReadString8()
        
106         If modGuilds.r_ClanGeneraPropuesta(userindex, guild, e_RELACIONES_GUILD.PAZ, proposal, errorStr) Then
108             Call WriteConsoleMsg(userindex, "Propuesta de paz enviada", e_FontTypeNames.FONTTYPE_GUILD)

            Else
110             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            End If

        End With
        
        Exit Sub
        
ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildOfferPeace", Erl)
114

End Sub

''
' Handles the "GuildOfferAlliance" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildOfferAlliance(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild    As String
            Dim proposal As String
            Dim errorStr As String
        
102         guild = Reader.ReadString8()
104         proposal = Reader.ReadString8()
        
106         If modGuilds.r_ClanGeneraPropuesta(userindex, guild, e_RELACIONES_GUILD.ALIADOS, proposal, errorStr) Then
108             Call WriteConsoleMsg(userindex, "Propuesta de alianza enviada", e_FontTypeNames.FONTTYPE_GUILD)

            Else
110             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            End If

        End With
        
        Exit Sub
        
ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildOfferPeace", Erl)
114

End Sub

''
' Handles the "GuildAllianceDetails" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildAllianceDetails(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild    As String
            Dim errorStr As String
            Dim details  As String
        
102         guild = Reader.ReadString8()
        
104         details = modGuilds.r_VerPropuesta(userindex, guild, e_RELACIONES_GUILD.ALIADOS, errorStr)
        
106         If LenB(details) = 0 Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)
            Else
110             Call WriteOfferDetails(userindex, details)

            End If

        End With
        
        Exit Sub
        
ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildOfferPeace", Erl)
114

End Sub

''
' Handles the "GuildPeaceDetails" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildPeaceDetails(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild    As String
            Dim errorStr As String
            Dim details  As String
        
102         guild = Reader.ReadString8()
        
104         details = modGuilds.r_VerPropuesta(userindex, guild, e_RELACIONES_GUILD.PAZ, errorStr)
        
106         If LenB(details) = 0 Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            Else
110             Call WriteOfferDetails(userindex, details)

            End If
            
        End With
        
        Exit Sub
        
ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildPeaceDetails", Erl)
114

End Sub

''
' Handles the "GuildRequestJoinerInfo" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildRequestJoinerInfo(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim user    As String
            Dim details As String
        
102         user = Reader.ReadString8()
        
104         details = modGuilds.a_DetallesAspirante(userindex, user)
        
106         If LenB(details) = 0 Then
108             Call WriteConsoleMsg(userindex, "El personaje no ha mandado solicitud, o no est�s habilitado para verla.", e_FontTypeNames.FONTTYPE_GUILD)
            Else
110             Call WriteShowUserRequest(userindex, details)

            End If

        End With
        
        Exit Sub
        
ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildRequestJoinerInfo", Erl)
114

End Sub

''
' Handles the "GuildAlliancePropList" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildAlliancePropList(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo HandleGuildAlliancePropList_Err
    
100     Call WriteAlianceProposalsList(userindex, r_ListaDePropuestas(userindex, e_RELACIONES_GUILD.ALIADOS))
        
        Exit Sub

HandleGuildAlliancePropList_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildAlliancePropList", Erl)
104
        
End Sub

''
' Handles the "GuildPeacePropList" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildPeacePropList(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
      
        On Error GoTo HandleGuildPeacePropList_Err

100     Call WritePeaceProposalsList(userindex, r_ListaDePropuestas(userindex, e_RELACIONES_GUILD.PAZ))
        
        Exit Sub

HandleGuildPeacePropList_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildPeacePropList", Erl)
104
        
End Sub

''
' Handles the "GuildDeclareWar" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildDeclareWar(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild           As String
            Dim errorStr        As String
            Dim otherGuildIndex As Integer
        
102         guild = Reader.ReadString8()
        
104         otherGuildIndex = modGuilds.r_DeclararGuerra(userindex, guild, errorStr)
        
106         If otherGuildIndex = 0 Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            Else
                'WAR shall be!
110             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("TU CLAN HA ENTRADO EN GUERRA CON " & guild, e_FontTypeNames.FONTTYPE_GUILD))
112             Call SendData(SendTarget.ToGuildMembers, otherGuildIndex, PrepareMessageConsoleMsg(modGuilds.GuildName(.GuildIndex) & " LE DECLARA LA GUERRA A TU CLAN", e_FontTypeNames.FONTTYPE_GUILD))
114             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessagePlayWave(45, NO_3D_SOUND, NO_3D_SOUND))
116             Call SendData(SendTarget.ToGuildMembers, otherGuildIndex, PrepareMessagePlayWave(45, NO_3D_SOUND, NO_3D_SOUND))

            End If

        End With
        
        Exit Sub
        
ErrHandler:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildPeacePropList", Erl)
120

End Sub

''
' Handles the "GuildNewWebsite" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildNewWebsite(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo ErrHandler

100     Call modGuilds.ActualizarWebSite(userindex, Reader.ReadString8())

        Exit Sub
        
ErrHandler:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildNewWebsite", Erl)
104

End Sub

''
' Handles the "GuildAcceptNewMember" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildAcceptNewMember(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim errorStr As String
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
108         tUser = NameIndex(UserName)

            If tUser > 0 Then
104             If Not modGuilds.a_AceptarAspirante(userindex, UserName, errorStr) Then
106                 Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)
                Else
112                 Call modGuilds.m_ConectarMiembroAClan(tUser, .GuildIndex)
114                 Call RefreshCharStatus(tUser)
116                 Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("[" & UserName & "] ha sido aceptado como miembro del clan.", e_FontTypeNames.FONTTYPE_GUILD))
118                 Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessagePlayWave(43, NO_3D_SOUND, NO_3D_SOUND))
                End If
            Else
                Call WriteConsoleMsg(userindex, "El usuario debe estar conectado para ser aceptado como miembro del clan.", e_FontTypeNames.FONTTYPE_GUILD)
                Exit Sub
            End If

        End With
        
        Exit Sub
        
ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildAcceptNewMember", Erl)
122

End Sub

''
' Handles the "GuildRejectNewMember" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildRejectNewMember(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 01/08/07
        'Last Modification by: (liquid)
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim errorStr As String
            Dim UserName As String
            Dim Reason   As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
104         Reason = Reader.ReadString8()
        
106         If Not modGuilds.a_RechazarAspirante(userindex, UserName, errorStr) Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            Else
110             tUser = NameIndex(UserName)
            
112             If tUser > 0 Then
114                 Call WriteConsoleMsg(tUser, errorStr & " : " & Reason, e_FontTypeNames.FONTTYPE_GUILD)
                Else
                    'hay que grabar en el char su rechazo
116                 Call modGuilds.a_RechazarAspiranteChar(UserName, .GuildIndex, Reason)

                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildAcceptNewMember", Erl)
120

End Sub

''
' Handles the "GuildKickMember" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildKickMember(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName   As String
            Dim GuildIndex As Integer
        
102         UserName = Reader.ReadString8()
        
104         GuildIndex = modGuilds.m_EcharMiembroDeClan(userindex, UserName)
        
106         If GuildIndex > 0 Then
                Dim expulsadoIndex As Integer
108             expulsadoIndex = NameIndex(UserName)
110             If expulsadoIndex > 0 Then Call WriteConsoleMsg(expulsadoIndex, "Has sido expulsado del clan.", e_FontTypeNames.FONTTYPE_GUILD)
            
112             Call SendData(SendTarget.ToGuildMembers, GuildIndex, PrepareMessageConsoleMsg(UserName & " fue expulsado del clan.", e_FontTypeNames.FONTTYPE_GUILD))
114             Call SendData(SendTarget.ToGuildMembers, GuildIndex, PrepareMessagePlayWave(45, NO_3D_SOUND, NO_3D_SOUND))
            Else
116             Call WriteConsoleMsg(userindex, "No pod�s expulsar ese personaje del clan.", e_FontTypeNames.FONTTYPE_GUILD)

            End If

        End With
        
        Exit Sub
        
ErrHandler:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildKickMember", Erl)
120

End Sub

''
' Handles the "GuildUpdateNews" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildUpdateNews(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     Call modGuilds.ActualizarNoticias(userindex, Reader.ReadString8())

        Exit Sub
        
ErrHandler:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildUpdateNews", Erl)
104

End Sub

''
' Handles the "GuildMemberInfo" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildMemberInfo(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     Call modGuilds.SendDetallesPersonaje(userindex, Reader.ReadString8())

        Exit Sub
        
ErrHandler:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildMemberInfo", Erl)
104

End Sub

''
' Handles the "GuildOpenElections" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildOpenElections(ByVal userindex As Integer)
        
        On Error GoTo HandleGuildOpenElections_Err
        
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            Dim Error As String
        
102         If Not modGuilds.v_AbrirElecciones(userindex, Error) Then
104             Call WriteConsoleMsg(userindex, Error, e_FontTypeNames.FONTTYPE_GUILD)
            Else
106             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("�Han comenzado las elecciones del clan! Puedes votar escribiendo /VOTO seguido del nombre del personaje, por ejemplo: /VOTO " & .name, e_FontTypeNames.FONTTYPE_GUILD))

            End If

        End With
        
        Exit Sub

HandleGuildOpenElections_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildOpenElections", Erl)
110
        
End Sub

''
' Handles the "GuildRequestMembership" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildRequestMembership(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild       As String
            Dim application As String
            Dim errorStr    As String
        
102         guild = Reader.ReadString8()
104         application = Reader.ReadString8()
        
106         If Not modGuilds.a_NuevoAspirante(userindex, guild, application, errorStr) Then
108             Call WriteConsoleMsg(userindex, errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            Else
110             Call WriteConsoleMsg(userindex, "Tu solicitud ha sido enviada. Espera prontas noticias del l�der de " & guild & ".", e_FontTypeNames.FONTTYPE_GUILD)

            End If

        End With
        
        Exit Sub
        
ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildRequestMembership", Erl)
114

End Sub

''
' Handles the "GuildRequestDetails" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildRequestDetails(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler
 
100     Call modGuilds.SendGuildDetails(userindex, Reader.ReadString8())

        Exit Sub
        
ErrHandler:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildRequestDetails", Erl)
104

End Sub

''
' Handles the "Online" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleOnline(ByVal userindex As Integer)
        
        On Error GoTo HandleOnline_Err

        '***************************************************
        'Ladder 17/12/20 : Envio records de usuarios y uptime
        '***************************************************
        
        Dim i         As Long
        Dim Count     As Long
        Dim Time      As Long
        Dim UpTimeStr As String
    
100     With UserList(userindex)
102         For i = 1 To LastUser

104             If UserList(i).flags.UserLogged Then
110                 Count = Count + 1

                End If

112         Next i
        
            'Get total time in seconds
114         Time = ((GetTickCount()) - tInicioServer) \ 1000
        
            'Get times in dd:hh:mm:ss format
116         UpTimeStr = (Time Mod 60) & " segundos."
118         Time = Time \ 60
        
120         UpTimeStr = (Time Mod 60) & " minutos, " & UpTimeStr
122         Time = Time \ 60
        
124         UpTimeStr = (Time Mod 24) & " horas, " & UpTimeStr
126         Time = Time \ 24
        
128         If Time = 1 Then
130             UpTimeStr = Time & " d�a, " & UpTimeStr
            Else
132             UpTimeStr = Time & " d�as, " & UpTimeStr
    
            End If
    
134         Call WriteConsoleMsg(userindex, "Server Online: " & UpTimeStr, e_FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(userindex, "N�mero de usuarios: " & CStr(Count) & " conectados.", e_FontTypeNames.FONTTYPE_INFOIAO)
            Call WriteConsoleMsg(userindex, "Tiempo en l�nea: " & UpTimeStr & " Record de usuarios en simultaneo: " & RecordUsuarios & ".", e_FontTypeNames.FONTTYPE_INFOIAO)
        End With
        
        Exit Sub

HandleOnline_Err:
146     Call TraceError(Err.Number, Err.Description, "Protocol.HandleOnline", Erl)
148
        
End Sub

''
' Handles the "Quit" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleQuit(ByVal userindex As Integer)
        
        On Error GoTo HandleQuit_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 04/15/2008 (NicoNZ)
        'If user is invisible, it automatically becomes
        'visible before doing the countdown to exit
        '04/15/2008 - No se reseteaban los contadores de invi ni de ocultar. (NicoNZ)
        '***************************************************
        
    Dim tUser        As Integer
    
100     With UserList(userindex)

102         If .flags.Paralizado = 1 Then
104             Call WriteConsoleMsg(userindex, "No pod�s salir estando paralizado.", e_FontTypeNames.FONTTYPE_WARNING)
                Exit Sub

            End If
        
            'exit secure commerce
106         If .ComUsu.DestUsu > 0 Then
108             tUser = .ComUsu.DestUsu
            
110             If UserList(tUser).flags.UserLogged Then
            
112                 If UserList(tUser).ComUsu.DestUsu = userindex Then
114                     Call WriteConsoleMsg(tUser, "Comercio cancelado por el otro usuario", e_FontTypeNames.FONTTYPE_TALK)
116                     Call FinComerciarUsu(tUser)

                    End If

                End If
            
118             Call WriteConsoleMsg(userindex, "Comercio cancelado. ", e_FontTypeNames.FONTTYPE_TALK)
120             Call FinComerciarUsu(userindex)

        End If

138         Call Cerrar_Usuario(userindex)

        End With

        Exit Sub

HandleQuit_Err:
140     Call TraceError(Err.Number, Err.Description, "Protocol.HandleQuit", Erl)
142
        
End Sub

''
' Handles the "GuildLeave" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildLeave(ByVal userindex As Integer)
        
        On Error GoTo HandleGuildLeave_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        Dim GuildIndex As Integer
    
100     With UserList(userindex)

            'obtengo el guildindex
102         GuildIndex = m_EcharMiembroDeClan(userindex, .name)
        
104         If GuildIndex > 0 Then
106             Call WriteConsoleMsg(userindex, "Dejas el clan.", e_FontTypeNames.FONTTYPE_GUILD)
108             Call SendData(SendTarget.ToGuildMembers, GuildIndex, PrepareMessageConsoleMsg(.name & " deja el clan.", e_FontTypeNames.FONTTYPE_GUILD))
            Else
110             Call WriteConsoleMsg(userindex, "Tu no puedes salir de ning�n clan.", e_FontTypeNames.FONTTYPE_GUILD)

            End If

        End With

        Exit Sub

HandleGuildLeave_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildLeave", Erl)
114
        
End Sub

''
' Handles the "RequestAccountState" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestAccountState(ByVal userindex As Integer)
        
        On Error GoTo HandleRequestAccountState_Err
        
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        Dim earnings   As Integer
        Dim percentage As Integer
    
100     With UserList(userindex)

            'Dead people can't check their accounts
102         If .flags.Muerto = 1 Then
104             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
106         If .flags.TargetNPC = 0 Then
108             Call WriteConsoleMsg(userindex, "Primero tenes que seleccionar un personaje, hace click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
110         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 3 Then
112             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos del vendedor.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
114         Select Case NpcList(.flags.TargetNPC).NPCtype

                Case e_NPCType.Banquero
116                 Call WriteChatOverHead(userindex, "Tenes " & PonerPuntos(.Stats.Banco) & " monedas de oro en tu cuenta.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
            
118             Case e_NPCType.Timbero

120                 If Not .flags.Privilegios And e_PlayerType.user Then
122                     earnings = Apuestas.Ganancias - Apuestas.Perdidas
                    
124                     If earnings >= 0 And Apuestas.Ganancias <> 0 Then
126                         percentage = Int(earnings * 100 / Apuestas.Ganancias)

                        End If
                    
128                     If earnings < 0 And Apuestas.Perdidas <> 0 Then
130                         percentage = Int(earnings * 100 / Apuestas.Perdidas)

                        End If
                    
132                     Call WriteConsoleMsg(userindex, "Entradas: " & PonerPuntos(Apuestas.Ganancias) & " Salida: " & PonerPuntos(Apuestas.Perdidas) & " Ganancia Neta: " & PonerPuntos(earnings) & " (" & percentage & "%) Jugadas: " & Apuestas.Jugadas, e_FontTypeNames.FONTTYPE_INFO)

                    End If

            End Select

        End With
        
        Exit Sub

HandleRequestAccountState_Err:
134     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestAccountState", Erl)
136
        
End Sub

''
' Handles the "PetStand" message.
'
' @param    userIndex The index of the user sending the message.

Private Sub HandlePetStand(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo HandlePetStand_Err
        
100     With UserList(userindex)

            'Dead people can't use pets
102         If .flags.Muerto = 1 Then
104             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
106         If .flags.TargetNPC = 0 Then
108             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hace click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Make sure it's close enough
110         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 10 Then
112             Call WriteConsoleMsg(userindex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Make sure it's his pet
114         If NpcList(.flags.TargetNPC).MaestroUser <> userindex Then Exit Sub
        
            'Do it!
116         NpcList(.flags.TargetNPC).Movement = e_TipoAI.Estatico
        
118         Call Expresar(.flags.TargetNPC, userindex)

        End With
        
        Exit Sub

HandlePetStand_Err:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePetStand", Erl)
122
        
End Sub

''
' Handles the "PetFollow" message.
'
' @param    userIndex The index of the user sending the message.

Private Sub HandlePetFollow(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo HandlePetFollow_Err
        
100     With UserList(userindex)

            'Dead users can't use pets
102         If .flags.Muerto = 1 Then
104             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
106         If .flags.TargetNPC = 0 Then
108             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hace click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Make sure it's close enough
110         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 10 Then
112             Call WriteConsoleMsg(userindex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Make usre it's the user's pet
114         If NpcList(.flags.TargetNPC).MaestroUser <> userindex Then Exit Sub
        
            'Do it
116         Call FollowAmo(.flags.TargetNPC)
        
118         Call Expresar(.flags.TargetNPC, userindex)

        End With
        
        Exit Sub

HandlePetFollow_Err:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePetFollow", Erl)
122
        
End Sub

''
' Handles the "PetLeave" message.
'
' @param    userIndex The index of the user sending the message.

Private Sub HandlePetLeave(ByVal userindex As Integer)
        '***************************************************
        
        On Error GoTo HandlePetLeave_Err
        
100     With UserList(userindex)

            'Dead users can't use pets
102         If .flags.Muerto = 1 Then
104             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
106         If .flags.TargetNPC = 0 Then
108             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hace click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Make usre it's the user's pet
110         If NpcList(.flags.TargetNPC).MaestroUser <> userindex Then Exit Sub

112         Call QuitarNPC(.flags.TargetNPC)

        End With
        
        Exit Sub

HandlePetLeave_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePetLeave", Erl)
116
        
End Sub

''
' Handles the "GrupoMsg" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGrupoMsg(ByVal userindex As Integer)
        On Error GoTo ErrHandler
100     With UserList(userindex)
            Dim chat As String
102         chat = Reader.ReadString8()
104         If LenB(chat) <> 0 Then

108             If .Grupo.EnGrupo = True Then

                    Dim i As Byte
         
110                 For i = 1 To UserList(.Grupo.Lider).Grupo.CantidadMiembros
112                     Call WriteConsoleMsg(UserList(.Grupo.Lider).Grupo.Miembros(i), .name & "> " & chat, e_FontTypeNames.FONTTYPE_New_Amarillo_Verdoso)
114                     Call WriteChatOverHead(UserList(.Grupo.Lider).Grupo.Miembros(i), chat, UserList(userindex).Char.CharIndex, &HFF8000)
116                 Next i
                Else
118                 Call WriteConsoleMsg(userindex, "Grupo> No estas en ningun grupo.", e_FontTypeNames.FONTTYPE_New_GRUPO)
                End If
            End If
        End With
        Exit Sub
ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGrupoMsg", Erl)
122

End Sub

''
' Handles the "TrainList" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleTrainList(ByVal userindex As Integer)
        
        On Error GoTo HandleTrainList_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'Dead users can't use pets
102         If .flags.Muerto = 1 Then
104             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
106         If .flags.TargetNPC = 0 Then
108             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hace click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Make sure it's close enough
110         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 10 Then
112             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Make sure it's the trainer
114         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Entrenador Then Exit Sub
        
116         Call WriteTrainerCreatureList(userindex, .flags.TargetNPC)

        End With

        Exit Sub

HandleTrainList_Err:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTrainList", Erl)
120
        
End Sub

''
' Handles the "Rest" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRest(ByVal userindex As Integer)
        
        On Error GoTo HandleRest_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'Dead users can't use pets
102         If .flags.Muerto = 1 Then
104             Call WriteConsoleMsg(userindex, "��Est�s muerto!! Solo pod�s usar items cuando est�s vivo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
106         If HayOBJarea(.Pos, FOGATA) Then
108             Call WriteRestOK(userindex)
            
110             If Not .flags.Descansar Then
112                 Call WriteConsoleMsg(userindex, "Te acomod�s junto a la fogata y comenz�s a descansar.", e_FontTypeNames.FONTTYPE_INFO)
                Else
114                 Call WriteConsoleMsg(userindex, "Te levantas.", e_FontTypeNames.FONTTYPE_INFO)

                End If
            
116             .flags.Descansar = Not .flags.Descansar
            Else

118             If .flags.Descansar Then
120                 Call WriteRestOK(userindex)
122                 Call WriteConsoleMsg(userindex, "Te levantas.", e_FontTypeNames.FONTTYPE_INFO)
                
124                 .flags.Descansar = False
                    Exit Sub

                End If
            
126             Call WriteConsoleMsg(userindex, "No hay ninguna fogata junto a la cual descansar.", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With

        Exit Sub

HandleRest_Err:
128     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRest", Erl)
130
        
End Sub

''
' Handles the "Meditate" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleMeditate(ByVal userindex As Integer)
        
        On Error GoTo HandleMeditate_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 04/15/08 (NicoNZ)
        'Arregl� un bug que mandaba un index de la meditacion diferente
        'al que decia el server.
        '***************************************************
        
100     With UserList(userindex)

            'Si ya tiene el mana completo, no lo dejamos meditar.
102         If .Stats.MinMAN = .Stats.MaxMAN Then Exit Sub
                           
            'Las clases NO MAGICAS no meditan...
104         If .clase = e_Class.Hunter Or .clase = e_Class.Trabajador Or .clase = e_Class.Warrior Or .clase = e_Class.Pirat Or .clase = e_Class.Thief Then Exit Sub

106         If .flags.Muerto = 1 Then
108             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
110         If .flags.Montado = 1 Then
112             Call WriteConsoleMsg(userindex, "No podes meditar estando montado.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

114         .flags.Meditando = Not .flags.Meditando

116         If .flags.Meditando Then

118             .Counters.TimerMeditar = 0
                .Counters.TiempoInicioMeditar = 0

120             Select Case .Stats.ELV

                    Case 1 To 14
122                     .Char.FX = e_Meditaciones.MeditarInicial
                      'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageParticleFX(UserList(UserIndex).Char.CharIndex, 37, -1, False))

124                 Case 15 To 24
                        'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageParticleFX(UserList(UserIndex).Char.CharIndex, 38, -1, False))
126                     .Char.FX = e_Meditaciones.MeditarMayor15

128                 Case 25 To 35
130                     .Char.FX = e_Meditaciones.MeditarMayor30
                        'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageParticleFX(UserList(UserIndex).Char.CharIndex, 39, -1, False))

132                 Case 35 To 44
134                     .Char.FX = e_Meditaciones.MeditarMayor40

136                 Case 45 To 46
138                     .Char.FX = e_Meditaciones.MeditarMayor45

140                 Case Else
142                     .Char.FX = e_Meditaciones.MeditarMayor47

                End Select

            Else
144             .Char.FX = 0

                'Call WriteLocaleMsg(UserIndex, "123", e_FontTypeNames.FONTTYPE_INFO)
            End If

146         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageMeditateToggle(.Char.CharIndex, .Char.FX))

        End With
        
        Exit Sub

HandleMeditate_Err:
148     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMeditate", Erl)
150
        
End Sub

''
' Handles the "Resucitate" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleResucitate(ByVal userindex As Integer)
        
        On Error GoTo HandleResucitate_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'Se asegura que el target es un npc
102         If .flags.TargetNPC = 0 Then
104             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hace click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate NPC and make sure player is dead
106         If (NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Revividor And (NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.ResucitadorNewbie Or Not EsNewbie(userindex))) Or .flags.Muerto = 0 Then Exit Sub
        
            'Make sure it's close enough
108         If Distancia(.Pos, NpcList(.flags.TargetNPC).Pos) > 10 Then
110             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "El sacerdote no puede resucitarte debido a que est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
112         Call RevivirUsuario(userindex)
114         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageParticleFX(UserList(userindex).Char.CharIndex, e_ParticulasIndex.Curar, 100, False))
116         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessagePlayWave("104", UserList(userindex).Pos.X, UserList(userindex).Pos.Y))
118         Call WriteConsoleMsg(userindex, "�Has sido resucitado!", e_FontTypeNames.FONTTYPE_INFO)

        End With
        
        Exit Sub

HandleResucitate_Err:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleResucitate", Erl)
122
        
End Sub

''
' Handles the "Heal" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleHeal(ByVal userindex As Integer)
        
        On Error GoTo HandleHeal_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'Se asegura que el target es un npc
102         If .flags.TargetNPC = 0 Then
104             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hace click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
106         If (NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Revividor And NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.ResucitadorNewbie) Or .flags.Muerto <> 0 Then Exit Sub
        
108         If Distancia(.Pos, NpcList(.flags.TargetNPC).Pos) > 10 Then
110             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "El sacerdote no puede curarte debido a que est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
112         .Stats.MinHp = .Stats.MaxHp
        
114         Call WriteUpdateHP(userindex)
        
116         Call WriteConsoleMsg(userindex, "��Has sido curado!!", e_FontTypeNames.FONTTYPE_INFO)

        End With
        
        Exit Sub

HandleHeal_Err:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleHeal", Erl)
120
        
End Sub

''
' Handles the "RequestStats" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestStats(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        On Error GoTo HandleRequestStats_Err

100     Call SendUserStatsTxt(userindex, userindex)
        
        Exit Sub

HandleRequestStats_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestStats", Erl)
104
        
End Sub

''
' Handles the "Help" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleHelp(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        On Error GoTo HandleHelp_Err

100     Call SendHelp(userindex)
        
        Exit Sub

HandleHelp_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleHelp", Erl)
104
        
End Sub

''
' Handles the "CommerceStart" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCommerceStart(ByVal userindex As Integer)
        
        On Error GoTo HandleCommerceStart_Err
        
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'Dead people can't commerce
102         If .flags.Muerto = 1 Then
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
104             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Is it already in commerce mode??
106         If .flags.Comerciando Then
108             Call WriteConsoleMsg(userindex, "Ya est�s comerciando", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
110         If .flags.TargetNPC > 0 Then
                
                'VOS, como GM, NO podes COMERCIAR con NPCs. (excepto Dioses y Admins)
112             If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Dios Or e_PlayerType.Admin)) = 0 Then
114                 Call WriteConsoleMsg(userindex, "No pod�s vender items.", e_FontTypeNames.FONTTYPE_WARNING)
                    Exit Sub

                End If
                
                'Does the NPC want to trade??
116             If NpcList(.flags.TargetNPC).Comercia = 0 Then
118                 If LenB(NpcList(.flags.TargetNPC).Desc) <> 0 Then
120                     Call WriteChatOverHead(userindex, "No tengo ning�n inter�s en comerciar.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

                    End If
                
                    Exit Sub

                End If
            
122             If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 3 Then
124                 Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                    'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos del vendedor.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If
            
                'Start commerce....
126             Call IniciarComercioNPC(userindex)
                
128         ElseIf .flags.TargetUser > 0 Then

                ' **********************  Comercio con Usuarios  *********************
                
                'VOS, como GM, NO podes COMERCIAR con usuarios. (excepto Dioses y Admins)
130             If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Dios Or e_PlayerType.Admin)) = 0 Then
132                 Call WriteConsoleMsg(userindex, "No pod�s vender items.", e_FontTypeNames.FONTTYPE_WARNING)
                    Exit Sub

                End If
                
                'NO podes COMERCIAR CON un GM. (excepto Dioses y Admins)
134             If (UserList(.flags.TargetUser).flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Dios Or e_PlayerType.Admin)) = 0 Then
136                 Call WriteConsoleMsg(userindex, "No pod�s vender items a este usuario.", e_FontTypeNames.FONTTYPE_WARNING)
                    Exit Sub

                End If
                
                'Is the other one dead??
138             If UserList(.flags.TargetUser).flags.Muerto = 1 Then
                    Call FinComerciarUsu(.flags.TargetUser, True)
140                 Call WriteConsoleMsg(userindex, "��No pod�s comerciar con los muertos!!", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If
            
                'Is it me??
142             If .flags.TargetUser = userindex Then
144                 Call WriteConsoleMsg(userindex, "No pod�s comerciar con vos mismo...", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If
            
                'Check distance
146             If .Pos.Map <> UserList(.flags.TargetUser).Pos.Map Or Distancia(UserList(.flags.TargetUser).Pos, .Pos) > 3 Then
                    Call FinComerciarUsu(.flags.TargetUser, True)
148                 Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                    'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos del usuario.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If
 
                'Check if map is not safe
                If MapInfo(.Pos.Map).Seguro = 0 Then
                    Call FinComerciarUsu(.flags.TargetUser, True)
                    Call WriteConsoleMsg(userindex, "No se puede usar el comercio seguro en zona insegura.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If

                'Is he already trading?? is it with me or someone else??
150             If UserList(.flags.TargetUser).flags.Comerciando = True Then
                    Call FinComerciarUsu(.flags.TargetUser, True)
152                 Call WriteConsoleMsg(userindex, "No pod�s comerciar con el usuario en este momento.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If
            
                'Initialize some variables...
154             .ComUsu.DestUsu = .flags.TargetUser
156             .ComUsu.DestNick = UserList(.flags.TargetUser).name
158             .ComUsu.cant = 0
160             .ComUsu.Objeto = 0
162             .ComUsu.Acepto = False
            
                'Rutina para comerciar con otro usuario
164             Call IniciarComercioConUsuario(userindex, .flags.TargetUser)

            Else
166             Call WriteConsoleMsg(userindex, "Primero haz click izquierdo sobre el personaje.", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub

HandleCommerceStart_Err:
168     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCommerceStart", Erl)
170
        
End Sub

''
' Handles the "BankStart" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBankStart(ByVal userindex As Integer)
        
        On Error GoTo HandleBankStart_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'Dead people can't commerce
102         If .flags.Muerto = 1 Then
104             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
106         If .flags.Comerciando Then
108             Call WriteConsoleMsg(userindex, "Ya est�s comerciando", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
110         If .flags.TargetNPC > 0 Then
112             If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 6 Then
114                 Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                    'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos del vendedor.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If
            
                'If it's the banker....
116             If NpcList(.flags.TargetNPC).NPCtype = e_NPCType.Banquero Then
118                 Call IniciarDeposito(userindex)

                End If

            Else
120             Call WriteConsoleMsg(userindex, "Primero haz click izquierdo sobre el personaje.", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub

HandleBankStart_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBankStart", Erl)
124
        
End Sub

''
' Handles the "Enlist" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleEnlist(ByVal userindex As Integer)
        
        On Error GoTo HandleEnlist_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

            'Validate target NPC
104         If .flags.TargetNPC = 0 Then
106             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hac� click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
108         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Enlistador Or .flags.Muerto <> 0 Then Exit Sub
        
110         If Distancia(.Pos, NpcList(.flags.TargetNPC).Pos) > 4 Then
112             Call WriteConsoleMsg(userindex, "Debes acercarte m�s.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
114         If NpcList(.flags.TargetNPC).flags.Faccion = 0 Then
116             Call EnlistarArmadaReal(userindex)
            
            Else
118             Call EnlistarCaos(userindex)

            End If

        End With
        
        Exit Sub

HandleEnlist_Err:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleEnlist", Erl)
122
        
End Sub

''
' Handles the "Information" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleInformation(ByVal userindex As Integer)
        
        On Error GoTo HandleInformation_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'Validate target NPC
102         If .flags.TargetNPC = 0 Then
104             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hac� click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
106         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Enlistador Or .flags.Muerto <> 0 Then Exit Sub
        
108         If Distancia(.Pos, NpcList(.flags.TargetNPC).Pos) > 4 Then
110             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
112         If NpcList(.flags.TargetNPC).flags.Faccion = 0 Then
114             If .Faccion.ArmadaReal = 0 Then
116                 Call WriteChatOverHead(userindex, "No perteneces a las tropas reales!!!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                    Exit Sub

                End If

118             Call WriteChatOverHead(userindex, "Tu deber es combatir criminales, cada 100 criminales que derrotes te dar� una recompensa.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
            
            Else

120             If .Faccion.FuerzasCaos = 0 Then
122                 Call WriteChatOverHead(userindex, "No perteneces a la legi�n oscura!!!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                    Exit Sub

                End If

124             Call WriteChatOverHead(userindex, "Tu deber es sembrar el caos y la desesperanza, cada 100 ciudadanos que derrotes te dar� una recompensa.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

            End If

        End With
        
        Exit Sub

HandleInformation_Err:
126     Call TraceError(Err.Number, Err.Description, "Protocol.HandleInformation", Erl)
128
        
End Sub

''
' Handles the "Reward" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleReward(ByVal userindex As Integer)
        
        On Error GoTo HandleReward_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            'Validate target NPC
102         If .flags.TargetNPC = 0 Then
104             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, hac� click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
106         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Enlistador Or .flags.Muerto <> 0 Then Exit Sub
        
108         If Distancia(.Pos, NpcList(.flags.TargetNPC).Pos) > 4 Then
110             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
112         If NpcList(.flags.TargetNPC).flags.Faccion = 0 Then
        
114             If .Faccion.ArmadaReal = 0 Then
116                 Call WriteChatOverHead(userindex, "No perteneces a las tropas reales!!!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                    Exit Sub

                End If

118             Call RecompensaArmadaReal(userindex)
            
            Else

120             If .Faccion.FuerzasCaos = 0 Then
122                 Call WriteChatOverHead(userindex, "No perteneces a la legi�n oscura!!!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                    Exit Sub

                End If

124             Call RecompensaCaos(userindex)

            End If

        End With
        
        Exit Sub

HandleReward_Err:
126     Call TraceError(Err.Number, Err.Description, "Protocol.HandleReward", Erl)
128
        
End Sub

''
' Handles the "RequestMOTD" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestMOTD(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        On Error GoTo HandleRequestMOTD_Err

100     Call SendMOTD(userindex)
        
        Exit Sub

HandleRequestMOTD_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestMOTD", Erl)
104
        
End Sub

''
' Handles the "UpTime" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUpTime(ByVal userindex As Integer)
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 01/10/08
        '01/10/2008 - Marcos Martinez (ByVal) - Automatic restart removed from the server along with all their assignments and varibles
        '***************************************************
   
        On Error GoTo HandleUpTime_Err

        Dim Time      As Long
        Dim UpTimeStr As String
    
        'Get total time in seconds
100     Time = ((GetTickCount()) - tInicioServer) \ 1000
    
        'Get times in dd:hh:mm:ss format
102     UpTimeStr = (Time Mod 60) & " segundos."
104     Time = Time \ 60
    
106     UpTimeStr = (Time Mod 60) & " minutos, " & UpTimeStr
108     Time = Time \ 60
    
110     UpTimeStr = (Time Mod 24) & " horas, " & UpTimeStr
112     Time = Time \ 24
    
114     If Time = 1 Then
116         UpTimeStr = Time & " d�a, " & UpTimeStr
        Else
118         UpTimeStr = Time & " d�as, " & UpTimeStr

        End If
    
120     Call WriteConsoleMsg(userindex, "Server Online: " & UpTimeStr, e_FontTypeNames.FONTTYPE_INFO)
        
        Exit Sub

HandleUpTime_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUpTime", Erl)
124
        
End Sub


''
' Handles the "GuildMessage" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildMessage(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim chat As String
102         chat = Reader.ReadString8()
               
            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.GuildMessage
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "GuildMessage", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub
       
104         If LenB(chat) <> 0 Then
                ' WyroX: Foto-denuncias - Push message
                Dim i As Integer

108             For i = 1 To UBound(.flags.ChatHistory) - 1
110                 .flags.ChatHistory(i) = .flags.ChatHistory(i + 1)
                Next
                
112             .flags.ChatHistory(UBound(.flags.ChatHistory)) = chat
            
114             If .GuildIndex > 0 Then
                    'HarThaoS: si es leade mando un 10 para el status del color(medio villero pero me dio paja)
116                 If LCase(GuildLeader(.GuildIndex)) = .name Then
118                     Call SendData(SendTarget.ToDiosesYclan, .GuildIndex, PrepareMessageGuildChat(.name & "> " & chat, 10))
                    Else
                    
120                     Call SendData(SendTarget.ToDiosesYclan, .GuildIndex, PrepareMessageGuildChat(.name & "> " & chat, .Faccion.Status))
                        Call SendData(SendTarget.ToClanArea, userindex, PrepareMessageChatOverHead("NOCONSOLA*< " & chat & " >", .Char.CharIndex, RGB(255, 255, 0)))
                    End If
                    'TODO : Con la 0.12.1 se debe definir si esto vuelve o se borra (/CMSG overhead)
                   ' Call SendData(SendTarget.ToAll, UserIndex, UserList(UserIndex).Pos.Map, "||" & vbYellow & "�< " & chat & " >�" & CStr(UserList(UserIndex).Char.CharIndex))
                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildMessage", Erl)
124

End Sub

''
' Handles the "CentinelReport" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCentinelReport(ByVal userindex As Integer)
        
        On Error GoTo HandleCentinelReport_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     Call CentinelaCheckClave(userindex, Reader.ReadInt())

        Exit Sub

HandleCentinelReport_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCentinelReport", Erl)
104
        
End Sub

''
' Handles the "GuildOnline" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildOnline(ByVal userindex As Integer)
        
        On Error GoTo HandleGuildOnline_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

            Dim onlineList As String
102             onlineList = modGuilds.m_ListaDeMiembrosOnline(userindex, .GuildIndex)
        
104         If .GuildIndex <> 0 Then
106             Call WriteConsoleMsg(userindex, "Compa�eros de tu clan conectados: " & onlineList, e_FontTypeNames.FONTTYPE_GUILDMSG)
            
            Else
108             Call WriteConsoleMsg(userindex, "No pertences a ning�n clan.", e_FontTypeNames.FONTTYPE_GUILDMSG)

            End If

        End With
        
        Exit Sub

HandleGuildOnline_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildOnline", Erl)
112
        
End Sub

''
' Handles the "CouncilMessage" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCouncilMessage(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim chat As String
102             chat = Reader.ReadString8()
        
104         If LenB(chat) <> 0 Then
                ' WyroX: Foto-denuncias - Push message
                Dim i As Long
108             For i = 1 To UBound(.flags.ChatHistory) - 1
110                 .flags.ChatHistory(i) = .flags.ChatHistory(i + 1)
                Next
                
112             .flags.ChatHistory(UBound(.flags.ChatHistory)) = chat
            
114             If .flags.Privilegios And e_PlayerType.RoyalCouncil Then
116                 Call SendData(SendTarget.ToConsejo, userindex, PrepareMessageConsoleMsg("(Consejero) " & .name & "> " & chat, e_FontTypeNames.FONTTYPE_CONSEJO))

118             ElseIf .flags.Privilegios And e_PlayerType.ChaosCouncil Then
120                 Call SendData(SendTarget.ToConsejoCaos, userindex, PrepareMessageConsoleMsg("(Consejero) " & .name & "> " & chat, e_FontTypeNames.FONTTYPE_CONSEJOCAOS))

                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCouncilMessage", Erl)
124

End Sub

''
' Handles the "RoleMasterRequest" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRoleMasterRequest(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim request As String
102             request = Reader.ReadString8()
        
104         If LenB(request) <> 0 Then
106             Call WriteConsoleMsg(userindex, "Su solicitud ha sido enviada", e_FontTypeNames.FONTTYPE_INFO)
108             Call SendData(SendTarget.ToRolesMasters, 0, PrepareMessageConsoleMsg(.name & " PREGUNTA ROL: " & request, e_FontTypeNames.FONTTYPE_GUILDMSG))

            End If

        End With
    
        Exit Sub
        
ErrHandler:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRoleMasterRequest", Erl)
112

End Sub

''
' Handles the "ChangeDescription" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleChangeDescription(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Description As String
102             Description = Reader.ReadString8()
        
104         If .flags.Muerto = 1 Then
106             Call WriteConsoleMsg(userindex, "No pod�s cambiar la descripci�n estando muerto.", e_FontTypeNames.FONTTYPE_INFOIAO)

            Else
            
108             If Len(Description) > 128 Then
110                 Call WriteConsoleMsg(userindex, "La descripci�n es muy larga.", e_FontTypeNames.FONTTYPE_INFOIAO)

112             ElseIf Not DescripcionValida(Description) Then
114                 Call WriteConsoleMsg(userindex, "La descripci�n tiene car�cteres inv�lidos.", e_FontTypeNames.FONTTYPE_INFOIAO)
                
                Else
116                 .Desc = Trim$(Description)
118                 Call WriteConsoleMsg(userindex, "La descripci�n a cambiado.", e_FontTypeNames.FONTTYPE_INFOIAO)

                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChangeDescription", Erl)
122

End Sub

''
' Handles the "GuildVote" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildVote(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim vote     As String
            Dim errorStr As String
        
102         vote = Reader.ReadString8()
        
104         If Not modGuilds.v_UsuarioVota(userindex, vote, errorStr) Then
106             Call WriteConsoleMsg(userindex, "Voto NO contabilizado: " & errorStr, e_FontTypeNames.FONTTYPE_GUILD)

            Else
108             Call WriteConsoleMsg(userindex, "Voto contabilizado.", e_FontTypeNames.FONTTYPE_GUILD)

            End If
 
        End With
        
        Exit Sub
        
ErrHandler:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildVote", Erl)
112

End Sub

''
' Handles the "Punishments" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandlePunishments(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim name As String
102             name = Reader.ReadString8()

            ' Si un GM usa este comando, me fijo que me haya dado el nick del PJ a analizar.
104         If EsGM(userindex) And LenB(name) = 0 Then Exit Sub
        
            Dim Count As Integer

106         If (InStrB(name, "\") <> 0) Then
108             name = Replace(name, "\", vbNullString)

            End If

110         If (InStrB(name, "/") <> 0) Then
112             name = Replace(name, "/", vbNullString)

            End If

114         If (InStrB(name, ":") <> 0) Then
116             name = Replace(name, ":", vbNullString)

            End If

118         If (InStrB(name, "|") <> 0) Then
120             name = Replace(name, "|", vbNullString)

            End If
           
            Dim TargetUserName As String

122         If EsGM(userindex) Then
        
124             If PersonajeExiste(name) Then
126                 TargetUserName = name
                
                Else
128                 Call WriteConsoleMsg(userindex, "El personaje " & TargetUserName & " no existe.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If
            
            Else
        
130             TargetUserName = .name
            
            End If

134         Count = GetUserAmountOfPunishmentsDatabase(TargetUserName)


138         If Count = 0 Then
140             Call WriteConsoleMsg(userindex, "Sin prontuario..", e_FontTypeNames.FONTTYPE_INFO)
            Else
144             Call SendUserPunishmentsDatabase(userindex, TargetUserName)
            End If

        End With
    
        Exit Sub
    
ErrHandler:
152     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePunishments", Erl)
154

End Sub


''
' Handles the "Gamble" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGamble(ByVal userindex As Integer)
        
        On Error GoTo HandleGamble_Err
        
        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim amount As Integer
102             amount = Reader.ReadInt()
        
104         If .flags.Muerto = 1 Then
106             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                
108         ElseIf .flags.TargetNPC = 0 Then
                'Validate target NPC
110             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, haz click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)

112         ElseIf Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 10 Then
114             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                ' Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                
116         ElseIf NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Timbero Then
118             Call WriteChatOverHead(userindex, "No tengo ning�n inter�s en apostar.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

120         ElseIf amount < 1 Then
122             Call WriteChatOverHead(userindex, "El m�nimo de apuesta es 1 moneda.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

124         ElseIf amount > 10000 Then
126             Call WriteChatOverHead(userindex, "El m�ximo de apuesta es 10.000 monedas.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

128         ElseIf .Stats.GLD < amount Then
130             Call WriteChatOverHead(userindex, "No tienes esa cantidad.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

            Else

132             If RandomNumber(1, 100) <= 45 Then
134                 .Stats.GLD = .Stats.GLD + amount
136                 Call WriteChatOverHead(userindex, "�Felicidades! Has ganado " & PonerPuntos(amount) & " monedas de oro!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                
138                 Apuestas.Perdidas = Apuestas.Perdidas + amount
140                 Call WriteVar(DatPath & "apuestas.dat", "Main", "Perdidas", CStr(Apuestas.Perdidas))
                Else
142                 .Stats.GLD = .Stats.GLD - amount
144                 Call WriteChatOverHead(userindex, "Lo siento, has perdido " & PonerPuntos(amount) & " monedas de oro.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                
146                 Apuestas.Ganancias = Apuestas.Ganancias + amount
148                 Call WriteVar(DatPath & "apuestas.dat", "Main", "Ganancias", CStr(Apuestas.Ganancias))

                End If
            
150             Apuestas.Jugadas = Apuestas.Jugadas + 1
            
152             Call WriteVar(DatPath & "apuestas.dat", "Main", "Jugadas", CStr(Apuestas.Jugadas))
            
154             Call WriteUpdateGold(userindex)

            End If

        End With

        Exit Sub

HandleGamble_Err:
156     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGamble", Erl)
158
        
End Sub


''
' Handles the "BankExtractGold" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBankExtractGold(ByVal userindex As Integer)
        
        On Error GoTo HandleBankExtractGold_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim amount As Long
102             amount = Reader.ReadInt()
        
            'Dead people can't leave a faction.. they can't talk...
104         If .flags.Muerto = 1 Then
106             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
108         If .flags.TargetNPC = 0 Then
110             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, haz click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
112         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Banquero Then Exit Sub
        
114         If Distancia(.Pos, NpcList(.flags.TargetNPC).Pos) > 10 Then
116             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
118         If amount > 0 And amount <= .Stats.Banco Then
120             .Stats.Banco = .Stats.Banco - amount
122             .Stats.GLD = .Stats.GLD + amount
                Call WriteChatOverHead(userindex, "Ten�s " & .Stats.Banco & " monedas de oro en tu cuenta.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

124             Call WriteUpdateGold(userindex)
126           '  Call WriteGoliathInit(UserIndex)
                Call WriteUpdateBankGld(userindex)

            Else
128             Call WriteChatOverHead(userindex, "No ten�s esa cantidad.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

            End If

        End With

        Exit Sub

HandleBankExtractGold_Err:
130     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBankExtractGold", Erl)
132
        
End Sub

''
' Handles the "LeaveFaction" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleLeaveFaction(ByVal userindex As Integer)
        
        On Error GoTo HandleLeaveFaction_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        
100     With UserList(userindex)

            'Dead people can't leave a faction.. they can't talk...
102         If .flags.Muerto = 1 Then
104             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
106         If .Faccion.ArmadaReal = 0 And .Faccion.FuerzasCaos = 0 Then
108             If .Faccion.Status = 1 Then
110                 Call VolverCriminal(userindex)
112                 Call WriteConsoleMsg(userindex, "Ahora sos un criminal.", e_FontTypeNames.FONTTYPE_INFOIAO)
                    Exit Sub
                End If
            End If
        
            'Validate target NPC
114         If .flags.TargetNPC = 0 Then
116             If .Faccion.ArmadaReal = 1 Then
118                 Call WriteConsoleMsg(userindex, "Para salir del ejercito debes ir a visitar al rey.", e_FontTypeNames.FONTTYPE_INFOIAO)
                    Exit Sub
120             ElseIf .Faccion.FuerzasCaos = 1 Then
122                 Call WriteConsoleMsg(userindex, "Para salir de la legion debes ir a visitar al diablo.", e_FontTypeNames.FONTTYPE_INFOIAO)
                    Exit Sub
                End If
                Exit Sub
            End If
        
124         If NpcList(.flags.TargetNPC).NPCtype = e_NPCType.Enlistador Then
                'Quit the Royal Army?
126             If .Faccion.ArmadaReal = 1 Then
128                 If NpcList(.flags.TargetNPC).flags.Faccion = 0 Then
                
                        'HarThaoS
                        'Si tiene clan
130                     If .GuildIndex > 0 Then
                            'Y no es leader
132                         If Not PersonajeEsLeader(.name) Then
                                'Me fijo de que alineaci�n es el clan, si es ARMADA, lo hecho
                                If GuildAlignmentIndex(.GuildIndex) = e_ALINEACION_GUILD.ALINEACION_ARMADA Then
                                    Call m_EcharMiembroDeClan(userindex, .name)
136                                 Call WriteConsoleMsg(userindex, "Has dejado el clan.", e_FontTypeNames.FONTTYPE_GUILD)
                                End If
                            Else
                                'Me fijo si est� en un clan armada, en ese caso no lo dejo salir de la facci�n
                                If GuildAlignmentIndex(.GuildIndex) = e_ALINEACION_GUILD.ALINEACION_ARMADA Then
138                                 Call WriteChatOverHead(userindex, "Para dejar la facci�n primero deber�s ceder el liderazgo del clan", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                                    Exit Sub
                                End If
                            End If
                        End If
                    
140                     Call ExpulsarFaccionReal(userindex)
142                     Call WriteChatOverHead(userindex, "Ser�s bienvenido a las fuerzas imperiales si deseas regresar.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

                        Exit Sub
                    Else
144                     Call WriteChatOverHead(userindex, "���Sal de aqu� buf�n!!!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                   
                    End If

                    'Quit the Chaos Legion??
146             ElseIf .Faccion.FuerzasCaos = 1 Then

148                 If NpcList(.flags.TargetNPC).flags.Faccion = 2 Then
                        'HarThaoS
                        'Si tiene clan
                         If .GuildIndex > 0 Then
                            'Y no es leader
                            If Not PersonajeEsLeader(.name) Then
                                'Me fijo de que alineaci�n es el clan, si es CAOS, lo hecho
                                If GuildAlignmentIndex(.GuildIndex) = e_ALINEACION_GUILD.ALINEACION_CAOTICA Then
                                    Call m_EcharMiembroDeClan(userindex, .name)
                                 Call WriteConsoleMsg(userindex, "Has dejado el clan.", e_FontTypeNames.FONTTYPE_GUILD)
                                End If
                            Else
                                'Me fijo si est� en un clan CAOS, en ese caso no lo dejo salir de la facci�n
                                If GuildAlignmentIndex(.GuildIndex) = e_ALINEACION_GUILD.ALINEACION_CAOTICA Then
                                    Call WriteChatOverHead(userindex, "Para dejar la facci�n primero deber�s ceder el liderazgo del clan", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                                    Exit Sub
                                End If
                            End If
                        End If
                    
160                     Call ExpulsarFaccionCaos(userindex)
162                     Call WriteChatOverHead(userindex, "Ya volver�s arrastrandote.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                    Else
164                     Call WriteChatOverHead(userindex, "Sal de aqu� maldito criminal", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

                    End If

                Else
166                 Call WriteChatOverHead(userindex, "�No perteneces a ninguna facci�n!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

                End If

            End If
    
        End With
        
        Exit Sub

HandleLeaveFaction_Err:
168     Call TraceError(Err.Number, Err.Description, "Protocol.HandleLeaveFaction", Erl)
170
        
End Sub

''
' Handles the "BankDepositGold" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBankDepositGold(ByVal userindex As Integer)
        
        On Error GoTo HandleBankDepositGold_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim amount As Long
102             amount = Reader.ReadInt()
        
            'Dead people can't leave a faction.. they can't talk...
104         If .flags.Muerto = 1 Then
106             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
108         If .flags.TargetNPC = 0 Then
110             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, haz click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
            
112         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Banquero Then Exit Sub
        
114         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 10 Then
116             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
118         If amount > 0 And amount <= .Stats.GLD Then
120             .Stats.Banco = .Stats.Banco + amount
122             .Stats.GLD = .Stats.GLD - amount
                Call WriteChatOverHead(userindex, "Ten�s " & .Stats.Banco & " monedas de oro en tu cuenta.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
            
124             Call WriteUpdateGold(userindex)
126            ' Call WriteGoliathInit(UserIndex)
                Call WriteUpdateBankGld(userindex)
            Else
128             Call WriteChatOverHead(userindex, "No ten�s esa cantidad.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)

            End If

        End With
        
        Exit Sub

HandleBankDepositGold_Err:
130     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBankDepositGold", Erl)
132
        
End Sub

''
' Handles the "Denounce" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleFinEvento(ByVal userindex As Integer)
        
        On Error GoTo HandleDenounce_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.RoleMaster)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

106         If EventoActivo Then
108             Call FinalizarEvento
            Else
110             Call WriteConsoleMsg(userindex, "No hay ningun evento activo.", e_FontTypeNames.FONTTYPE_New_Eventos)
        
            End If
        
        End With
        
        Exit Sub

HandleDenounce_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDenounce", Erl)
114
        
End Sub ''

' Handles the "GuildMemberList" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildMemberList(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild       As String
            Dim memberCount As Integer
            Dim i           As Long
            Dim UserName    As String
        
102         guild = Reader.ReadString8()
        
104         If .flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios) Then

106             If (InStrB(guild, "\") <> 0) Then
108                 guild = Replace(guild, "\", "")

                End If

110             If (InStrB(guild, "/") <> 0) Then
112                 guild = Replace(guild, "/", "")

                End If
            
114             If Not FileExist(App.Path & "\guilds\" & guild & "-members.mem") Then
116                 Call WriteConsoleMsg(userindex, "No existe el clan: " & guild, e_FontTypeNames.FONTTYPE_INFO)

                Else
                
118                 memberCount = val(GetVar(App.Path & "\Guilds\" & guild & "-Members" & ".mem", "INIT", "NroMembers"))
                
120                 For i = 1 To memberCount
122                     UserName = GetVar(App.Path & "\Guilds\" & guild & "-Members" & ".mem", "Members", "Member" & i)
                    
124                     Call WriteConsoleMsg(userindex, UserName & "<" & guild & ">", e_FontTypeNames.FONTTYPE_INFO)
126                 Next i

                End If
        
            End If
            
        End With
        
        Exit Sub
        
ErrHandler:
128     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildMemberList", Erl)
130

End Sub

''
' Handles the "GMMessage" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGMMessage(ByVal userindex As Integer)
        On Error GoTo ErrHandler
100     With UserList(userindex)
            Dim Message As String
102         Message = Reader.ReadString8()
104         If EsGM(userindex) Then
106             Call LogGM(.name, "Mensaje a Gms: " & Message)
108             If LenB(Message) <> 0 Then
112                 Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.name & " � " & Message, e_FontTypeNames.FONTTYPE_GMMSG))
                End If

            End If

        End With

        Exit Sub
    
ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGMMessage", Erl)
116

End Sub

''
' Handles the "ShowName" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleShowName(ByVal userindex As Integer)
        
        On Error GoTo HandleShowName_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then
        
104             .showName = Not .showName 'Show / Hide the name
            
106             Call RefreshCharStatus(userindex)

            End If

        End With
        
        Exit Sub

HandleShowName_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleShowName", Erl)
110
        
End Sub

''
' Handles the "OnlineRoyalArmy" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleOnlineRoyalArmy(ByVal userindex As Integer)
        
        On Error GoTo HandleOnlineRoyalArmy_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And e_PlayerType.user Then Exit Sub
    
            Dim i    As Long
            Dim list As String

104         For i = 1 To LastUser

106             If UserList(i).ConnIDValida Then
108                 If UserList(i).Faccion.ArmadaReal = 1 Then
110                     If UserList(i).flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios) Or .flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin) Then
112                         list = list & UserList(i).name & ", "

                        End If

                    End If

                End If

114         Next i

        End With
    
116     If Len(list) > 0 Then
118         Call WriteConsoleMsg(userindex, "Armadas conectados: " & Left$(list, Len(list) - 2), e_FontTypeNames.FONTTYPE_INFO)
        Else
120         Call WriteConsoleMsg(userindex, "No hay Armadas conectados", e_FontTypeNames.FONTTYPE_INFO)

        End If
        
        Exit Sub

HandleOnlineRoyalArmy_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleOnlineRoyalArmy", Erl)
124
        
End Sub

''
' Handles the "OnlineChaosLegion" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleOnlineChaosLegion(ByVal userindex As Integer)
        
        On Error GoTo HandleOnlineChaosLegion_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And e_PlayerType.user Then Exit Sub
    
            Dim i    As Long
            Dim list As String

104         For i = 1 To LastUser

106             If UserList(i).ConnIDValida Then
108                 If UserList(i).Faccion.FuerzasCaos = 1 Then
110                     If UserList(i).flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios) Or .flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin) Then
112                         list = list & UserList(i).name & ", "

                        End If

                    End If

                End If

114         Next i

        End With

116     If Len(list) > 0 Then
118         Call WriteConsoleMsg(userindex, "Caos conectados: " & Left$(list, Len(list) - 2), e_FontTypeNames.FONTTYPE_INFO)
        
        Else
120         Call WriteConsoleMsg(userindex, "No hay Caos conectados", e_FontTypeNames.FONTTYPE_INFO)

        End If
        
        Exit Sub

HandleOnlineChaosLegion_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleOnlineChaosLegion", Erl)
124
        
End Sub

''
' Handles the "GoNearby" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGoNearby(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 01/10/07
        '
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
102             UserName = Reader.ReadString8()
        
            Dim tIndex As Integer

            Dim X      As Long
            Dim Y      As Long

            Dim i      As Long
            
            Dim Found  As Boolean
        
104         If Not EsGM(userindex) Then Exit Sub
        
            'Check the user has enough powers
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Or Ayuda.Existe(UserName) Then
108             tIndex = NameIndex(UserName)
            
110             If tIndex <= 0 Then
                    ' Si est� offline, comparamos privilegios offline, para no revelar si est� el gm conectado
112                 If CompararPrivilegios(.flags.Privilegios, UserDarPrivilegioLevel(UserName)) >= 0 Then
114                     Call WriteConsoleMsg(userindex, "Usuario offline.", e_FontTypeNames.FONTTYPE_INFO)
                    Else
116                     Call WriteConsoleMsg(userindex, "No pod�s ir cerca de un GM de mayor jerarqu�a.", e_FontTypeNames.FONTTYPE_INFO)
                    End If
                Else
118                 If CompararPrivilegiosUser(userindex, tIndex) >= 0 Then
120                     For i = 2 To 5 'esto for sirve ir cambiando la distancia destino
122                         For X = UserList(tIndex).Pos.X - i To UserList(tIndex).Pos.X + i
124                             For Y = UserList(tIndex).Pos.Y - i To UserList(tIndex).Pos.Y + i

126                                 If MapData(UserList(tIndex).Pos.Map, X, Y).userindex = 0 Then
128                                     If LegalPos(UserList(tIndex).Pos.Map, X, Y, True, True) Then
130                                         Call WriteConsoleMsg(userindex, "Te teletransportaste cerca de " & UserList(tIndex).name & ".", e_FontTypeNames.FONTTYPE_INFO)
132                                         Call WarpUserChar(userindex, UserList(tIndex).Pos.Map, X, Y, True)
134                                         Found = True
                                            Exit For
                                        End If

                                    End If

136                             Next Y
                            
138                             If Found Then Exit For  ' Feo, pero hay que abortar 3 fors sin usar GoTo
140                         Next X
                        
142                         If Found Then Exit For  ' Feo, pero hay que abortar 3 fors sin usar GoTo
144                     Next i
                    
                        'No space found??
146                     If Not Found Then
148                         Call WriteConsoleMsg(userindex, "Todos los lugares est�n ocupados.", e_FontTypeNames.FONTTYPE_INFO)
                        End If
                    Else
150                     Call WriteConsoleMsg(userindex, "No pod�s ir cerca de un GM de mayor jerarqu�a.", e_FontTypeNames.FONTTYPE_INFO)
                    End If
                End If
            Else
152             Call WriteConsoleMsg(userindex, "Servidor � No pod�s ir cerca de ningun Usuario si no pidio SOS.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
        
        Exit Sub
        
ErrHandler:
154     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGoNearby", Erl)
156

End Sub

''
' Handles the "Comment" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleComment(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim comment As String
102             comment = Reader.ReadString8()
        
104         If Not .flags.Privilegios And e_PlayerType.user Then
106             Call LogGM(.name, "Comentario: " & comment)
108             Call WriteConsoleMsg(userindex, "Comentario salvado...", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub
        
ErrHandler:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleComment", Erl)
112

End Sub

''
' Handles the "ServerTime" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleServerTime(ByVal userindex As Integer)
        
        On Error GoTo HandleServerTime_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 01/08/07
        'Last Modification by: (liquid)
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And e_PlayerType.user Then Exit Sub
    
104         Call LogGM(.name, "Hora.")

        End With
    
106     Call modSendData.SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Hora: " & Time & " " & Date, e_FontTypeNames.FONTTYPE_INFO))
        
        Exit Sub

HandleServerTime_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleServerTime", Erl)
110
        
End Sub

''
' Handles the "Where" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWhere(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.SemiDios Or e_PlayerType.Consejero Or e_PlayerType.user)) = 0 Then
106             tUser = NameIndex(UserName)

108             If tUser <= 0 Then
110                 Call WriteConsoleMsg(userindex, "Usuario offline.", e_FontTypeNames.FONTTYPE_INFO)
                Else

112                 If CompararPrivilegiosUser(userindex, tUser) >= 0 Then
114                     Call WriteConsoleMsg(userindex, "Ubicaci�n  " & UserName & ": " & UserList(tUser).Pos.Map & ", " & UserList(tUser).Pos.X & ", " & UserList(tUser).Pos.Y & ".", e_FontTypeNames.FONTTYPE_INFO)
116                     Call LogGM(.name, "/Donde " & UserName)
                    End If

                End If
            Else
118             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
        
        Exit Sub
        
ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWhere", Erl)
122

End Sub

''
' Handles the "CreaturesInMap" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCreaturesInMap(ByVal userindex As Integer)
        
        On Error GoTo HandleCreaturesInMap_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 30/07/06
        'Pablo (ToxicWaste): modificaciones generales para simplificar la visualizaci�n.
        '***************************************************

100     With UserList(userindex)

            Dim Map As Integer
            Dim i, j As Long
            Dim NPCcount1, NPCcount2 As Integer
            Dim NPCcant1() As Integer
            Dim NPCcant2() As Integer
            Dim List1()    As String
            Dim List2()    As String
        
102         Map = Reader.ReadInt()
        
104         If .flags.Privilegios And e_PlayerType.user Then Exit Sub
        
106         If MapaValido(Map) Then

108             For i = 1 To LastNPC

                    'VB isn't lazzy, so we put more restrictive condition first to speed up the process
110                 If NpcList(i).Pos.Map = Map Then

                        '�esta vivo?
112                     If NpcList(i).flags.NPCActive And NpcList(i).Hostile = 1 Then
114                         If NPCcount1 = 0 Then
116                             ReDim List1(0) As String
118                             ReDim NPCcant1(0) As Integer
120                             NPCcount1 = 1
122                             List1(0) = NpcList(i).name & ": (" & NpcList(i).Pos.X & "," & NpcList(i).Pos.Y & ")"
124                             NPCcant1(0) = 1
                            Else

126                             For j = 0 To NPCcount1 - 1

128                                 If Left$(List1(j), Len(NpcList(i).name)) = NpcList(i).name Then
130                                     List1(j) = List1(j) & ", (" & NpcList(i).Pos.X & "," & NpcList(i).Pos.Y & ")"
132                                     NPCcant1(j) = NPCcant1(j) + 1
                                        Exit For

                                    End If

134                             Next j

136                             If j = NPCcount1 Then
138                                 ReDim Preserve List1(0 To NPCcount1) As String
140                                 ReDim Preserve NPCcant1(0 To NPCcount1) As Integer
142                                 NPCcount1 = NPCcount1 + 1
144                                 List1(j) = NpcList(i).name & ": (" & NpcList(i).Pos.X & "," & NpcList(i).Pos.Y & ")"
146                                 NPCcant1(j) = 1

                                End If

                            End If

                        Else

148                         If NPCcount2 = 0 Then
150                             ReDim List2(0) As String
152                             ReDim NPCcant2(0) As Integer
154                             NPCcount2 = 1
156                             List2(0) = NpcList(i).name & ": (" & NpcList(i).Pos.X & "," & NpcList(i).Pos.Y & ")"
158                             NPCcant2(0) = 1
                            Else

160                             For j = 0 To NPCcount2 - 1

162                                 If Left$(List2(j), Len(NpcList(i).name)) = NpcList(i).name Then
164                                     List2(j) = List2(j) & ", (" & NpcList(i).Pos.X & "," & NpcList(i).Pos.Y & ")"
166                                     NPCcant2(j) = NPCcant2(j) + 1
                                        Exit For

                                    End If

168                             Next j

170                             If j = NPCcount2 Then
172                                 ReDim Preserve List2(0 To NPCcount2) As String
174                                 ReDim Preserve NPCcant2(0 To NPCcount2) As Integer
176                                 NPCcount2 = NPCcount2 + 1
178                                 List2(j) = NpcList(i).name & ": (" & NpcList(i).Pos.X & "," & NpcList(i).Pos.Y & ")"
180                                 NPCcant2(j) = 1

                                End If

                            End If

                        End If

                    End If

182             Next i
            
184             Call WriteConsoleMsg(userindex, "Npcs Hostiles en mapa: ", e_FontTypeNames.FONTTYPE_WARNING)

186             If NPCcount1 = 0 Then
188                 Call WriteConsoleMsg(userindex, "No hay NPCS Hostiles", e_FontTypeNames.FONTTYPE_INFO)
                Else

190                 For j = 0 To NPCcount1 - 1
192                     Call WriteConsoleMsg(userindex, NPCcant1(j) & " " & List1(j), e_FontTypeNames.FONTTYPE_INFO)
194                 Next j

                End If

196             Call WriteConsoleMsg(userindex, "Otros Npcs en mapa: ", e_FontTypeNames.FONTTYPE_WARNING)

198             If NPCcount2 = 0 Then
200                 Call WriteConsoleMsg(userindex, "No hay m�s NPCS", e_FontTypeNames.FONTTYPE_INFO)
                Else

202                 For j = 0 To NPCcount2 - 1
204                     Call WriteConsoleMsg(userindex, NPCcant2(j) & " " & List2(j), e_FontTypeNames.FONTTYPE_INFO)
206                 Next j

                End If

208             Call LogGM(.name, "Numero enemigos en mapa " & Map)

            End If

        End With
        
        Exit Sub

HandleCreaturesInMap_Err:
210     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCreaturesInMap", Erl)
212
        
End Sub

''
' Handles the "WarpMeToTarget" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWarpMeToTarget(ByVal userindex As Integer)
        
        On Error GoTo HandleWarpMeToTarget_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And e_PlayerType.user Then Exit Sub
        
104         Call WarpUserChar(userindex, .flags.TargetMap, .flags.TargetX, .flags.TargetY, True)
        
106         Call LogGM(.name, "/TELEPLOC a x:" & .flags.TargetX & " Y:" & .flags.TargetY & " Map:" & .Pos.Map)

        End With
        
        Exit Sub

HandleWarpMeToTarget_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWarpMeToTarget", Erl)
110
        
End Sub

''
' Handles the "WarpChar" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWarpChar(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim Map      As Integer
            Dim X        As Byte
            Dim Y        As Byte
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
104         Map = Reader.ReadInt()
106         X = Reader.ReadInt()
108         Y = Reader.ReadInt()

110         If .flags.Privilegios And e_PlayerType.user Then Exit Sub
            
112         If .flags.Privilegios And e_PlayerType.Consejero Then
        
114             If MapInfo(Map).Seguro = 0 Then
116                 Call WriteConsoleMsg(userindex, "Solo puedes transportarte a ciudades.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                    'Si manda yo o su propio nombre
118             ElseIf LCase$(UserName) <> LCase$(UserList(userindex).name) And UCase$(UserName) <> "YO" Then
120                 Call WriteConsoleMsg(userindex, "Solo puedes transportarte a ti mismo.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If

            End If
            
            '�Para que te vas a transportar a la misma posicion?
122         If .Pos.Map = Map And .Pos.X = X And .Pos.Y = Y Then Exit Sub
            
124         If MapaValido(Map) And LenB(UserName) <> 0 Then

126             If UCase$(UserName) <> "YO" Then
128                 tUser = NameIndex(UserName)
                
                Else
130                 tUser = userindex

                End If
            
132             If tUser <= 0 Then
134                 Call WriteConsoleMsg(userindex, "Usuario offline.", e_FontTypeNames.FONTTYPE_INFO)

136             ElseIf InMapBounds(Map, X, Y) Then
                    'HarThaoS no permitimos que se use el telep para llevas User a casas privadas. ReyarB
                    If UCase$(UserName) <> "YO" Then
                        If .flags.Privilegios And e_PlayerType.Consejero Or e_PlayerType.SemiDios Then
                            If Not EsMapaEvento(Map) Then
                                Call WriteConsoleMsg(userindex, "Solamente puedes teletransportar gente a mapas de evento.", e_FontTypeNames.FONTTYPE_INFO)
                                Exit Sub
                            End If
                        End If
                        Call WarpToLegalPos(tUser, Map, X, Y, True, True)
                    Else
138                     Call FindLegalPos(tUser, Map, X, Y)
140                     Call WarpUserChar(tUser, Map, X, Y, True)
                    End If
142                 If tUser <> userindex Then
144                     Call LogGM(.name, "Transport� a " & UserList(tUser).name & " hacia " & "Mapa" & Map & " X:" & X & " Y:" & Y)
                    End If
                        
                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:
146     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWarpChar", Erl)
148

End Sub

''
' Handles the "Silence" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSilence(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim minutos  As Integer
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
104         minutos = Reader.ReadInt()

106         If EsGM(userindex) Then
108             tUser = NameIndex(UserName)
        
110             If tUser <= 0 Then

112                 If PersonajeExiste(UserName) Then

114                     If CompararPrivilegios(.flags.Privilegios, UserDarPrivilegioLevel(UserName)) > 0 Then

116                         If minutos > 0 Then
118                             Call SilenciarUserDatabase(UserName, minutos)
120                             Call SavePenaDatabase(UserName, .name & ": silencio por " & Time & " minutos. " & Date & " " & Time)
122                             Call SendData(SendTarget.ToGM, 0, PrepareMessageConsoleMsg("Administraci�n � " & .name & " ha silenciado a " & UserName & "(offline) por " & minutos & " minutos.", e_FontTypeNames.FONTTYPE_GM))
124                             Call LogGM(.name, "Silenciar a " & UserList(tUser).name & " por " & minutos & " minutos.")
                            Else
126                             Call DesilenciarUserDatabase(UserName)
128                             Call SendData(SendTarget.ToGM, 0, PrepareMessageConsoleMsg("Administraci�n � " & .name & " ha desilenciado a " & UserName & "(offline).", e_FontTypeNames.FONTTYPE_GM))
130                             Call LogGM(.name, "Desilenciar a " & UserList(tUser).name & ".")

                            End If
                            
                        Else
                        
132                         Call WriteConsoleMsg(userindex, "No puedes silenciar a un administrador de mayor o igual rango.", e_FontTypeNames.FONTTYPE_INFO)

                        End If

                    Else
                    
134                     Call WriteConsoleMsg(userindex, "El personaje no existe.", e_FontTypeNames.FONTTYPE_INFO)

                    End If
                
136             ElseIf CompararPrivilegiosUser(userindex, tUser) > 0 Then

138                 If minutos > 0 Then
140                     UserList(tUser).flags.Silenciado = 1
142                     UserList(tUser).flags.MinutosRestantes = minutos
144                     UserList(tUser).flags.SegundosPasados = 0

146                     Call SavePenaDatabase(UserName, .name & ": silencio por " & Time & " minutos. " & Date & " " & Time)
148                     Call SendData(SendTarget.ToGM, 0, PrepareMessageConsoleMsg("Administraci�n � " & .name & " ha silenciado a " & UserList(tUser).name & " por " & minutos & " minutos.", e_FontTypeNames.FONTTYPE_GM))
150                     Call WriteConsoleMsg(tUser, "Has sido silenciado por los administradores, no podr�s hablar con otros usuarios. Utilice /GM para pedir ayuda.", e_FontTypeNames.FONTTYPE_GM)
152                     Call LogGM(.name, "Silenciar a " & UserList(tUser).name & " por " & minutos & " minutos.")

                    Else
                    
154                     UserList(tUser).flags.Silenciado = 1

156                     Call SendData(SendTarget.ToGM, 0, PrepareMessageConsoleMsg("Administraci�n � " & .name & " ha desilenciado a " & UserList(tUser).name & ".", e_FontTypeNames.FONTTYPE_GM))
158                     Call WriteConsoleMsg(tUser, "Has sido desilenciado.", e_FontTypeNames.FONTTYPE_GM)
160                     Call LogGM(.name, "Desilenciar a " & UserList(tUser).name & ".")

                    End If
                    
                Else
                
162                 Call WriteConsoleMsg(userindex, "No puedes silenciar a un administrador de mayor o igual rango.", e_FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End With
        
        Exit Sub
        
ErrHandler:
164     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSilence", Erl)
166

End Sub

''
' Handles the "SOSShowList" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSOSShowList(ByVal userindex As Integer)
        
        On Error GoTo HandleSOSShowList_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And e_PlayerType.user Then Exit Sub

104         Call WriteShowSOSForm(userindex)

        End With
        
        Exit Sub

HandleSOSShowList_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSOSShowList", Erl)
108
        
End Sub

''
' Handles the "SOSRemove" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSOSRemove(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
102             UserName = Reader.ReadString8()
        
104         If Not .flags.Privilegios And e_PlayerType.user Then Call Ayuda.Quitar(UserName)

        End With
        
        Exit Sub
        
ErrHandler:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSOSRemove", Erl)
108

End Sub

''
' Handles the "GoToChar" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGoToChar(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
            Dim X        As Byte
            Dim Y        As Byte
        
102         UserName = Reader.ReadString8()

104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
        
106             If LenB(UserName) <> 0 Then
108                 tUser = NameIndex(UserName)
                    
110                 If tUser <= 0 Then
112                     Call WriteConsoleMsg(userindex, "El jugador no est� online.", e_FontTypeNames.FONTTYPE_INFO)
                        Exit Sub

                    End If

                Else
114                 tUser = .flags.TargetUser

116                 If tUser <= 0 Then Exit Sub

                End If
      
118             If CompararPrivilegiosUser(tUser, userindex) > 0 Then
120                 Call WriteConsoleMsg(userindex, "Se le ha avisado a " & UserList(tUser).name & " que quieres ir a su posici�n.", e_FontTypeNames.FONTTYPE_INFO)
122                 Call WriteConsoleMsg(tUser, .name & " quiere transportarse a tu ubicaci�n. Escribe /sum " & .name & " para traerlo.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If

124             X = UserList(tUser).Pos.X
126             Y = UserList(tUser).Pos.Y + 1

128             Call FindLegalPos(userindex, UserList(tUser).Pos.Map, X, Y)
                
130             Call WarpUserChar(userindex, UserList(tUser).Pos.Map, X, Y, True)
                    
132             If .flags.AdminInvisible = 0 Then
134                 Call WriteConsoleMsg(tUser, .name & " se ha trasportado hacia donde te encuentras.", e_FontTypeNames.FONTTYPE_INFO)

                End If
                
136             Call WriteConsoleMsg(userindex, "Te has transportado hacia " & UserList(tUser).name & ".", e_FontTypeNames.FONTTYPE_INFO)
                    
138             Call LogGM(.name, "/IRA " & UserName & " Mapa:" & UserList(tUser).Pos.Map & " X:" & UserList(tUser).Pos.X & " Y:" & UserList(tUser).Pos.Y)
            Else
140             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo. solo puedes ir a Usuarios que piden SOS.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
        
        Exit Sub
        
ErrHandler:
142     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGoToChar", Erl)
144

End Sub



Private Sub HandleUseKey(ByVal userindex As Integer)
        
        On Error GoTo HandleUseKey_Err

100     With UserList(userindex)

            Dim Slot As Byte
102             Slot = Reader.ReadInt

104         Call UsarLlave(userindex, Slot)
                
        End With
        
        Exit Sub

HandleUseKey_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUseKey", Erl)
108
        
End Sub

''
' Handles the "Invisible" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleInvisible(ByVal userindex As Integer)
        
        On Error GoTo HandleInvisible_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero) Then Exit Sub
        
104         Call DoAdminInvisible(userindex)

        End With
        
        Exit Sub

HandleInvisible_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleInvisible", Erl)
108
        
End Sub

''
' Handles the "GMPanel" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGMPanel(ByVal userindex As Integer)
        
        On Error GoTo HandleGMPanel_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And e_PlayerType.user Then Exit Sub
        
104         Call WriteShowGMPanelForm(userindex)

        End With
        
        Exit Sub

HandleGMPanel_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGMPanel", Erl)
108
        
End Sub

''
' Handles the "GMPanel" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestUserList(ByVal userindex As Integer)
        
        On Error GoTo HandleRequestUserList_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 01/09/07
        'Last modified by: Lucas Tavolaro Ortiz (Tavo)
        'I haven`t found a solution to split, so i make an array of names
        '***************************************************
        Dim i       As Long
        Dim names() As String
        Dim Count   As Long
    
100     With UserList(userindex)
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.RoleMaster)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
106         ReDim names(1 To LastUser) As String
108         Count = 1
        
110         For i = 1 To LastUser

112             If (LenB(UserList(i).name) <> 0) Then
                
114                 names(Count) = UserList(i).name
116                 Count = Count + 1
 
                End If

118         Next i
        
120         If Count > 1 Then Call WriteUserNameList(userindex, names(), Count - 1)

        End With
        
        Exit Sub

HandleRequestUserList_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestUserList", Erl)
124
        
End Sub

''
' Handles the "Working" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWorking(ByVal userindex As Integer)
        
        On Error GoTo HandleWorking_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        Dim i     As Long
        Dim Users As String
    
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � /TRABAJANDO es un comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
106         For i = 1 To LastUser

108             If UserList(i).flags.UserLogged And UserList(i).Counters.Trabajando > 0 Then
110                 Users = Users & ", " & UserList(i).name
                
                    ' Display the user being checked by the centinel
112                 If modCentinela.Centinela.RevisandoUserIndex = i Then Users = Users & " (*)"

                End If

114         Next i
        
116         If LenB(Users) <> 0 Then
118             Users = Right$(Users, Len(Users) - 2)
120             Call WriteConsoleMsg(userindex, "Usuarios trabajando: " & Users, e_FontTypeNames.FONTTYPE_INFO)
            Else
122             Call WriteConsoleMsg(userindex, "No hay usuarios trabajando", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub

HandleWorking_Err:
124     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWorking", Erl)
126
        
End Sub

''
' Handles the "Hiding" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleHiding(ByVal userindex As Integer)
        
        On Error GoTo HandleHiding_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
        Dim i     As Long
        Dim Users As String
    
100     With UserList(userindex)

        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.RoleMaster)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
106         For i = 1 To LastUser

108             If (LenB(UserList(i).name) <> 0) And UserList(i).Counters.Ocultando > 0 Then
110                 Users = Users & UserList(i).name & ", "

                End If

112         Next i
        
114         If LenB(Users) <> 0 Then
116             Users = Left$(Users, Len(Users) - 2)
118             Call WriteConsoleMsg(userindex, "Usuarios ocultandose: " & Users, e_FontTypeNames.FONTTYPE_INFO)
            Else
120             Call WriteConsoleMsg(userindex, "No hay usuarios ocultandose", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub

HandleHiding_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleHiding", Erl)
124
        
End Sub

''
' Handles the "Jail" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleJail(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

        
        
        
            Dim UserName As String
            Dim Reason   As String
            Dim jailTime As Byte
            Dim Count    As Byte
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
104         Reason = Reader.ReadString8()
106         jailTime = Reader.ReadInt()
        
108         If InStr(1, UserName, "+") Then
110             UserName = Replace(UserName, "+", " ")

            End If
        
            '/carcel nick@motivo@<tiempo>
112         If .flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios) Then

114             If LenB(UserName) = 0 Or LenB(Reason) = 0 Then
116                 Call WriteConsoleMsg(userindex, "Utilice /carcel nick@motivo@tiempo", e_FontTypeNames.FONTTYPE_INFO)
                Else
118                 tUser = NameIndex(UserName)
                
120                 If tUser <= 0 Then
122                     Call WriteConsoleMsg(userindex, "El usuario no est� online.", e_FontTypeNames.FONTTYPE_INFO)
                    Else

124                     If EsGM(tUser) Then
126                         Call WriteConsoleMsg(userindex, "No pod�s encarcelar a administradores.", e_FontTypeNames.FONTTYPE_INFO)
                    
128                     ElseIf jailTime > 60 Then
130                         Call WriteConsoleMsg(userindex, "No pod�s encarcelar por m�s de 60 minutos.", e_FontTypeNames.FONTTYPE_INFO)
                        Else

132                         If (InStrB(UserName, "\") <> 0) Then
134                             UserName = Replace(UserName, "\", "")

                            End If

136                         If (InStrB(UserName, "/") <> 0) Then
138                             UserName = Replace(UserName, "/", "")

                            End If
                        
140                         If PersonajeExiste(UserName) Then
144                                 Call SavePenaDatabase(UserName, .name & ": CARCEL " & jailTime & "m, MOTIVO: " & Reason & " " & Date & " " & Time)
                            End If
                        
152                         Call Encarcelar(tUser, jailTime, .name)
154                         Call LogGM(.name, " encarcel� a " & UserName)

                        End If

                    End If

                End If
            Else
156             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
        
        Exit Sub
        
ErrHandler:
158     Call TraceError(Err.Number, Err.Description, "Protocol.HandleHiding", Erl)
160

End Sub

''
' Handles the "KillNPC" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleKillNPC(ByVal userindex As Integer)
        
        On Error GoTo HandleKillNPC_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 05/17/06
        '
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero) Then
104             Call WriteConsoleMsg(userindex, "Solo los Administradores y Dioses pueden usar este comando.", e_FontTypeNames.FONTTYPE_INFO)
            Exit Sub
            End If
        
            Dim tNPC As Integer
112         tNPC = .flags.TargetNPC
        
114         If tNPC > 0 Then

116             Call WriteConsoleMsg(userindex, "RMatas (con posible respawn) a: " & NpcList(tNPC).name, e_FontTypeNames.FONTTYPE_INFO)
            
                Dim auxNPC As t_Npc
118             auxNPC = NpcList(tNPC)
            
120             Call QuitarNPC(tNPC)
122             Call ReSpawnNpc(auxNPC)
            
            Else
124             Call WriteConsoleMsg(userindex, "Debes hacer click sobre el NPC antes", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub

HandleKillNPC_Err:
126     Call TraceError(Err.Number, Err.Description, "Protocol.HandleKillNPC", Erl)

128
        
End Sub

''
' Handles the "WarnUser" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleWarnUser(ByVal userindex As Integer)
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim Reason   As String

102         UserName = Reader.ReadString8()
104         Reason = Reader.ReadString8()
        
            ' Tenes que ser Admin, Dios o Semi-Dios
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) = 0 Then
108             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
            ' Me fijo que esten todos los parametros.
110         If Len(UserName) = 0 Or Len(Trim$(Reason)) = 0 Then
112             Call WriteConsoleMsg(userindex, "Formato inv�lido. /advertencia nick@motivo", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            Dim tUser As Integer
114         tUser = NameIndex(UserName)
        
            ' No advertir a GM's
116         If EsGM(tUser) Then
118             Call WriteConsoleMsg(userindex, "No podes advertir a Game Masters.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
120         If (InStrB(UserName, "\") <> 0) Then
122             UserName = Replace(UserName, "\", "")

            End If

124         If (InStrB(UserName, "/") <> 0) Then
126             UserName = Replace(UserName, "/", "")

            End If
                    
128         If PersonajeExiste(UserName) Then

132             Call SaveWarnDatabase(UserName, "ADVERTENCIA: " & Reason & " " & Date & " " & Time, .name)

            
                ' Para el GM
140             Call WriteConsoleMsg(userindex, "Has advertido a " & UserName, e_FontTypeNames.FONTTYPE_CENTINELA)
142             Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.name & " ha advertido a " & UserName & " por " & Reason, e_FontTypeNames.FONTTYPE_GM))
144             Call LogGM(.name, " advirtio a " & UserName & " por " & Reason)

                ' Si esta online...
146             If tUser >= 0 Then
                    ' Actualizo el valor en la memoria.
148                 UserList(tUser).Stats.Advertencias = UserList(tUser).Stats.Advertencias + 1
                
                    ' Para el usuario advertido
150                 Call WriteConsoleMsg(tUser, "Has sido advertido por " & Reason, e_FontTypeNames.FONTTYPE_CENTINELA)
152                 Call WriteConsoleMsg(tUser, "Ten�s " & UserList(tUser).Stats.Advertencias & " advertencias actualmente.", e_FontTypeNames.FONTTYPE_CENTINELA)
                
                    ' Cuando acumulas cierta cantidad de advertencias...
154                 Select Case UserList(tUser).Stats.Advertencias
                
                        Case 3
156                         Call Encarcelar(tUser, 30, "Servidor")
                    
158                     Case 5
                            ' TODO: Banear PJ alv.
                    
                    End Select
                
                End If

            End If
        
        End With
    
        Exit Sub
    
ErrHandler:

160     Call TraceError(Err.Number, Err.Description, "Protocol.HandleWarnUser", Erl)

162

End Sub

Private Sub HandleMensajeUser(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim Mensaje  As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
104         Mensaje = Reader.ReadString8()
        
106         If EsGM(userindex) Then
        
108             If LenB(UserName) = 0 Or LenB(Mensaje) = 0 Then
110                 Call WriteConsoleMsg(userindex, "Utilice /MENSAJEINFORMACION nick@mensaje", e_FontTypeNames.FONTTYPE_INFO)
                
                Else
112                 tUser = NameIndex(UserName)
                
114                 If tUser Then
116                     Call WriteConsoleMsg(tUser, "Mensaje recibido de " & .name & " [Game Master]:", e_FontTypeNames.FONTTYPE_New_DONADOR)
118                     Call WriteConsoleMsg(tUser, Mensaje, e_FontTypeNames.FONTTYPE_New_DONADOR)
                    Else
120                     If PersonajeExiste(UserName) Then
122                         Call SetMessageInfoDatabase(UserName, "Mensaje recibido de " & .name & " [Game Master]: " & vbNewLine & Mensaje & vbNewLine)
                        End If
                    End If

124                 Call WriteConsoleMsg(userindex, "Mensaje enviado a " & UserName & ": " & Mensaje, e_FontTypeNames.FONTTYPE_INFO)
126                 Call LogGM(.name, "Envi� mensaje como GM a " & UserName & ": " & Mensaje)

                End If

            End If

        End With
    
        Exit Sub

ErrHandler:
128     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMensajeUser", Erl)
130

End Sub

Private Sub HandleTraerBoveda(ByVal userindex As Integer)

        '***************************************************
        'Author: Ladder
        'Last Modification: 04/jul/2014
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)

102         Call UpdateUserHechizos(True, userindex, 0)
       
104         Call UpdateUserInv(True, userindex, 0)

        End With
    
        Exit Sub

ErrHandler:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTraerBoveda", Erl)
108

End Sub

Private Sub HandleEditChar(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/28/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
        
            Dim UserName      As String
            Dim tUser         As Integer

            Dim opcion        As Byte
            Dim Arg1          As String
            Dim Arg2          As String

            Dim valido        As Boolean

            Dim LoopC         As Byte
            Dim commandString As String
            Dim n             As Byte
            Dim tmpLong       As Long
        
102         UserName = Replace(Reader.ReadString8(), "+", " ")
        
104         If UCase$(UserName) = "YO" Then
106             tUser = userindex
            
            Else
108             tUser = NameIndex(UserName)
            End If
        
110         opcion = Reader.ReadInt()
112         Arg1 = Reader.ReadString8()
114         Arg2 = Reader.ReadString8()

            ' Si no es GM, no hacemos nada.
116         If Not EsGM(userindex) Then Exit Sub
        
            ' Si NO sos Dios o Admin,
118         If (.flags.Privilegios And e_PlayerType.Admin) = 0 Then

                ' Si te editas a vos mismo esta bien ;)
120             If userindex <> tUser Then Exit Sub
            
            End If
        
122         Select Case opcion

                Case e_EditOptions.eo_Gold
124
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

126                 If tUser <= 0 Then
128                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
130                     UserList(tUser).Stats.GLD = val(Arg1)
132                     Call WriteUpdateGold(tUser)

                    End If
                
134             Case e_EditOptions.eo_Experience
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

136                 If tUser <= 0 Then
138                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else

140                     If UserList(tUser).Stats.ELV < STAT_MAXELV Then
142                         UserList(tUser).Stats.Exp = UserList(tUser).Stats.Exp + val(Arg1)
144                         Call CheckUserLevel(tUser)
146                         Call WriteUpdateExp(tUser)
                            
                        Else
148                         Call WriteConsoleMsg(userindex, "El usuario es nivel m�ximo.", e_FontTypeNames.FONTTYPE_INFO)

                        End If

                    End If
                
150             Case e_EditOptions.eo_Body

152                 If tUser <= 0 Then

156                     Call SaveUserBodyDatabase(UserName, val(Arg1))

160                     Call WriteConsoleMsg(userindex, "Usuario Offline Alterado: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
162                     Call ChangeUserChar(tUser, val(Arg1), UserList(tUser).Char.Head, UserList(tUser).Char.Heading, UserList(tUser).Char.WeaponAnim, UserList(tUser).Char.ShieldAnim, UserList(tUser).Char.CascoAnim)

                    End If
                   
164             Case e_EditOptions.eo_Arma
                
166                 If tUser <= 0 Then
                       
168                     If Database_Enabled Then
                            'Call SaveUserBodyDatabase(UserName, val(Arg1))
                        Else
                            'Call WriteVar(CharPath & UserName & ".chr", "INIT", "Arma", Arg1)
                    
                        End If
                    
170                     Call WriteConsoleMsg(userindex, "Usuario Offline Alterado: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
172                     Call ChangeUserChar(tUser, UserList(tUser).Char.Body, UserList(tUser).Char.Head, UserList(tUser).Char.Heading, val(Arg1), UserList(tUser).Char.ShieldAnim, UserList(tUser).Char.CascoAnim)
                    
                    End If
                       
174             Case e_EditOptions.eo_Escudo
                
176                 If tUser <= 0 Then
                       
178                     If Database_Enabled Then
                            'Call SaveUserBodyDatabase(UserName, val(Arg1))
                        Else
                            'Call WriteVar(CharPath & UserName & ".chr", "INIT", "Arma", Arg1)
                    
                        End If
                    
180                     Call WriteConsoleMsg(userindex, "Usuario Offline Alterado: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
182                     Call ChangeUserChar(tUser, UserList(tUser).Char.Body, UserList(tUser).Char.Head, UserList(tUser).Char.Heading, UserList(tUser).Char.WeaponAnim, val(Arg1), UserList(tUser).Char.CascoAnim)
                    
                    End If
                       
184             Case e_EditOptions.eo_CASCO
                
186                 If tUser <= 0 Then
                       
188                     If Database_Enabled Then
                            'Call SaveUserBodyDatabase(UserName, val(Arg1))
                        Else
                            'Call WriteVar(CharPath & UserName & ".chr", "INIT", "Arma", Arg1)
                    
                        End If
                    
190                     Call WriteConsoleMsg(userindex, "Usuario Offline Alterado: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
192                     Call ChangeUserChar(tUser, UserList(tUser).Char.Body, UserList(tUser).Char.Head, UserList(tUser).Char.Heading, UserList(tUser).Char.WeaponAnim, UserList(tUser).Char.ShieldAnim, val(Arg1))
                    
                    End If
                       
194             Case e_EditOptions.eo_Particula

196                 If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub
                
198                 If Not .flags.Privilegios = Consejero Then
200                     If tUser <= 0 Then

202                         If Database_Enabled Then
                                'Call SaveUserBodyDatabase(UserName, val(Arg1))
                            Else
                                'Call WriteVar(CharPath & UserName & ".chr", "INIT", "Arma", Arg1)

                            End If

204                         Call WriteConsoleMsg(userindex, "Usuario Offline Alterado: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                        Else
                            'Call ChangeUserChar(tUser, UserList(tUser).Char.Body, UserList(tUser).Char.Head, UserList(tUser).Char.Heading, UserList(tUser).Char.WeaponAnim, UserList(tUser).Char.ShieldAnim, val(Arg1))
206                         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageParticleFX(.Char.CharIndex, val(Arg1), 9999, False))
208                         .Char.ParticulaFx = val(Arg1)
210                         .Char.loops = 9999

                        End If

                    End If
                
212             Case e_EditOptions.eo_Head

214                 If tUser <= 0 Then

218                     Call SaveUserHeadDatabase(UserName, val(Arg1))

222                     Call WriteConsoleMsg(userindex, "Usuario Offline Alterado: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
224                     Call ChangeUserChar(tUser, UserList(tUser).Char.Body, val(Arg1), UserList(tUser).Char.Heading, UserList(tUser).Char.WeaponAnim, UserList(tUser).Char.ShieldAnim, UserList(tUser).Char.CascoAnim)

                    End If
                
226             Case e_EditOptions.eo_CriminalsKilled
                
228                 If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub
                
230                 If tUser <= 0 Then
232                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else

234                     If val(Arg1) > MAXUSERMATADOS Then
236                         UserList(tUser).Faccion.CriminalesMatados = MAXUSERMATADOS
                        Else
238                         UserList(tUser).Faccion.CriminalesMatados = val(Arg1)

                        End If

                    End If
                
240             Case e_EditOptions.eo_CiticensKilled

242                 If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub
                
244                 If tUser <= 0 Then
246                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else

248                     If val(Arg1) > MAXUSERMATADOS Then
250                         UserList(tUser).Faccion.ciudadanosMatados = MAXUSERMATADOS
                        Else
252                         UserList(tUser).Faccion.ciudadanosMatados = val(Arg1)

                        End If

                    End If
                
254             Case e_EditOptions.eo_Level
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then Exit Sub

256                 If tUser <= 0 Then
258                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else

260                     If val(Arg1) > STAT_MAXELV Then
262                         Arg1 = CStr(STAT_MAXELV)
264                         Call WriteConsoleMsg(userindex, "No pod�s tener un nivel superior a " & STAT_MAXELV & ".", FONTTYPE_INFO)

                        End If
                        
266                     UserList(tUser).Stats.ELV = val(Arg1)

                    End If
                    
268                 Call WriteUpdateUserStats(userindex)
                
270             Case e_EditOptions.eo_Class

272                 If tUser <= 0 Then
274                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else

276                     For LoopC = 1 To NUMCLASES

278                         If Tilde(ListaClases(LoopC)) = Tilde(Arg1) Then Exit For
280                     Next LoopC
                        
282                     If LoopC > NUMCLASES Then
284                         Call WriteConsoleMsg(userindex, "Clase desconocida. Intente nuevamente.", e_FontTypeNames.FONTTYPE_INFO)
                        Else
286                         UserList(tUser).clase = LoopC

                        End If

                    End If
                
288             Case e_EditOptions.eo_Skills
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then Exit Sub

290                 For LoopC = 1 To NUMSKILLS

292                     If Tilde(Replace$(SkillsNames(LoopC), " ", "+")) = Tilde(Arg1) Then Exit For
294                 Next LoopC
                    
296                 If LoopC > NUMSKILLS Then
298                     Call WriteConsoleMsg(userindex, "Skill Inexistente!", e_FontTypeNames.FONTTYPE_INFO)
                    Else

300                     If tUser <= 0 Then
                        
304                         Call SaveUserSkillDatabase(UserName, LoopC, val(Arg2))

308                         Call WriteConsoleMsg(userindex, "Usuario Offline Alterado: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                        Else
310                         UserList(tUser).Stats.UserSkills(LoopC) = val(Arg2)

                        End If

                    End If
                
312             Case e_EditOptions.eo_SkillPointsLeft
                
314                 If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then Exit Sub
                
316                 If tUser <= 0 Then

320                     Call SaveUserSkillsLibres(UserName, val(Arg1))

324                     Call WriteConsoleMsg(userindex, "Usuario Offline Alterado: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
326                     UserList(tUser).Stats.SkillPts = val(Arg1)

                    End If
                
328             Case e_EditOptions.eo_Sex

330                 If tUser <= 0 Then
332                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
334                     Arg1 = UCase$(Arg1)

336                     If (Arg1 = "MUJER") Then
338                         UserList(tUser).genero = e_Genero.Mujer
                        
340                     ElseIf (Arg1 = "HOMBRE") Then
342                         UserList(tUser).genero = e_Genero.Hombre

                        End If

                    End If
                
344             Case e_EditOptions.eo_Raza

346                 If tUser <= 0 Then
348                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                        
                    Else
                    
350                     Arg1 = UCase$(Arg1)

352                     If (Arg1 = "HUMANO") Then
354                         UserList(tUser).raza = e_Raza.Humano
                            
356                     ElseIf (Arg1 = "ELFO") Then
358                         UserList(tUser).raza = e_Raza.Elfo
                            
360                     ElseIf (Arg1 = "DROW") Then
362                         UserList(tUser).raza = e_Raza.Drow
                            
364                     ElseIf (Arg1 = "ENANO") Then
366                         UserList(tUser).raza = e_Raza.Enano
                            
368                     ElseIf (Arg1 = "GNOMO") Then
370                         UserList(tUser).raza = e_Raza.Gnomo
                            
372                     ElseIf (Arg1 = "ORCO") Then
374                         UserList(tUser).raza = e_Raza.Orco

                        End If

                    End If
                    
376             Case e_EditOptions.eo_Vida
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

378                 If tUser <= 0 Then
380                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
382                     tmpLong = val(Arg1)
                        
384                     If tmpLong > 0 Then
386                         UserList(tUser).Stats.MaxHp = Min(tmpLong, STAT_MAXHP)
388                         UserList(tUser).Stats.MinHp = UserList(tUser).Stats.MaxHp
                            
390                         Call WriteUpdateUserStats(tUser)

                        End If

                    End If
                    
392             Case e_EditOptions.eo_Mana
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

394                 If tUser <= 0 Then
396                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
398                     tmpLong = val(Arg1)
                        
400                     If tmpLong > 0 Then
402                         UserList(tUser).Stats.MaxMAN = Min(tmpLong, STAT_MAXMP)
404                         UserList(tUser).Stats.MinMAN = UserList(tUser).Stats.MaxMAN
                            
406                         Call WriteUpdateUserStats(tUser)

                        End If

                    End If
                    
408             Case e_EditOptions.eo_Energia

                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

410                 If tUser <= 0 Then
412                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
414                     tmpLong = val(Arg1)
                        
416                     If tmpLong > 0 Then
418                         UserList(tUser).Stats.MaxSta = Min(tmpLong, STAT_MAXSTA)
420                         UserList(tUser).Stats.MinSta = UserList(tUser).Stats.MaxSta
                            
422                         Call WriteUpdateUserStats(tUser)

                        End If

                    End If
                        
424             Case e_EditOptions.eo_MinHP
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

426                 If tUser <= 0 Then
428                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
430                     tmpLong = val(Arg1)
                        
432                     If tmpLong >= 0 Then
434                         UserList(tUser).Stats.MinHp = Min(tmpLong, STAT_MAXHP)
                            
436                         Call WriteUpdateHP(tUser)

                        End If

                    End If
                    
438             Case e_EditOptions.eo_MinMP
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub
                    
440                 If tUser <= 0 Then
442                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
444                     tmpLong = val(Arg1)
                        
446                     If tmpLong >= 0 Then
448                         UserList(tUser).Stats.MinMAN = Min(tmpLong, STAT_MAXMP)
                            
450                         Call WriteUpdateMana(tUser)

                        End If

                    End If
                    
452             Case e_EditOptions.eo_Hit
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

454                 If tUser <= 0 Then
456                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
458                     tmpLong = val(Arg1)
                        
460                     If tmpLong >= 0 Then
462                         UserList(tUser).Stats.MaxHit = Min(tmpLong, STAT_MAXHIT)
464                         UserList(tUser).Stats.MinHIT = UserList(tUser).Stats.MaxHit

                        End If

                    End If
                    
466             Case e_EditOptions.eo_MinHit

468                 If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

                    If tUser <= 0 Then
470                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
472                     tmpLong = val(Arg1)
                        
474                     If tmpLong >= 0 Then
476                         UserList(tUser).Stats.MinHIT = Min(tmpLong, STAT_MAXHIT)

                        End If

                    End If
                    
478             Case e_EditOptions.eo_MaxHit
                    
                    If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

480                 If tUser <= 0 Then
482                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
484                     tmpLong = val(Arg1)
                        
486                     If tmpLong >= 0 Then
488                         UserList(tUser).Stats.MaxHit = Min(tmpLong, STAT_MAXHIT)

                        End If

                    End If
                    
490             Case e_EditOptions.eo_Desc

492                 If tUser <= 0 Then
494                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    
496                 ElseIf DescripcionValida(Arg1) Then
498                     UserList(tUser).Desc = Arg1
                        
                    Else
500                     Call WriteConsoleMsg(userindex, "Caracteres inv�lidos en la descripci�n.", e_FontTypeNames.FONTTYPE_INFO)

                    End If
                    
502             Case e_EditOptions.eo_Intervalo

504                 If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

506                 If tUser <= 0 Then
508                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
510                     Arg1 = UCase$(Arg1)
                        
512                     tmpLong = val(Arg2)
                        
514                     If tmpLong >= 0 Then
                    
516                         Select Case Arg1

                                Case "USAR"
518                                 UserList(tUser).Intervals.UsarClic = tmpLong
520                                 UserList(tUser).Intervals.UsarU = tmpLong
                                    
522                             Case "USAR_U", "USAR+U", "USAR-U"
524                                 UserList(tUser).Intervals.UsarU = tmpLong
                                    
526                             Case "USAR_CLIC", "USAR+CLIC", "USAR-CLIC", "USAR_CLICK", "USAR+CLICK", "USAR-CLICK"
528                                 UserList(tUser).Intervals.UsarClic = tmpLong
                                    
530                             Case "ARCO", "PROYECTILES"
532                                 UserList(tUser).Intervals.Arco = tmpLong
                                    
534                             Case "GOLPE", "GOLPES", "GOLPEAR"
536                                 UserList(tUser).Intervals.Golpe = tmpLong
                                    
538                             Case "MAGIA", "HECHIZO", "HECHIZOS", "LANZAR"
540                                 UserList(tUser).Intervals.Magia = tmpLong

542                             Case "COMBO"
544                                 UserList(tUser).Intervals.GolpeMagia = tmpLong
546                                 UserList(tUser).Intervals.MagiaGolpe = tmpLong

548                             Case "GOLPE-MAGIA", "GOLPE-HECHIZO"
550                                 UserList(tUser).Intervals.GolpeMagia = tmpLong

552                             Case "MAGIA-GOLPE", "HECHIZO-GOLPE"
554                                 UserList(tUser).Intervals.MagiaGolpe = tmpLong
                                    
556                             Case "GOLPE-USAR"
558                                 UserList(tUser).Intervals.GolpeUsar = tmpLong
                                    
560                             Case "TRABAJAR", "WORK", "TRABAJO"
562                                 UserList(tUser).Intervals.TrabajarConstruir = tmpLong
564                                 UserList(tUser).Intervals.TrabajarExtraer = tmpLong
                                    
566                             Case "TRABAJAR_EXTRAER", "EXTRAER", "TRABAJO_EXTRAER"
568                                 UserList(tUser).Intervals.TrabajarExtraer = tmpLong
                                    
570                             Case "TRABAJAR_CONSTRUIR", "CONSTRUIR", "TRABAJO_CONSTRUIR"
572                                 UserList(tUser).Intervals.TrabajarConstruir = tmpLong
                                    
574                             Case Else
                                    Exit Sub

                            End Select
                            
576                         Call WriteIntervals(tUser)
                            
                        End If

                    End If
                    
578             Case e_EditOptions.eo_Hogar

580                 If tUser <= 0 Then
582                     Call WriteConsoleMsg(userindex, "Usuario offline: " & UserName, e_FontTypeNames.FONTTYPE_INFO)
                    Else
584                     Arg1 = UCase$(Arg1)
                    
586                     Select Case Arg1

                            Case "NIX"
588                             UserList(tUser).Hogar = e_Ciudad.cNix

590                         Case "ULLA", "ULLATHORPE"
592                             UserList(tUser).Hogar = e_Ciudad.cUllathorpe

594                         Case "BANDER", "BANDERBILL"
596                             UserList(tUser).Hogar = e_Ciudad.cBanderbill

598                         Case "LINDOS"
600                             UserList(tUser).Hogar = e_Ciudad.cLindos

602                         Case "ARGHAL"
604                             UserList(tUser).Hogar = e_Ciudad.cArghal

606                         Case "ARKHEIN"
608                             UserList(tUser).Hogar = e_Ciudad.cArkhein

                        End Select

                    End If
                
610             Case Else
                
612                 Call WriteConsoleMsg(userindex, "Comando no permitido.", e_FontTypeNames.FONTTYPE_INFO)

            End Select

            'Log it!
614         commandString = "/MOD "
        
616         Select Case opcion

                Case e_EditOptions.eo_Gold
618                 commandString = commandString & "ORO "
            
620             Case e_EditOptions.eo_Experience
622                 commandString = commandString & "EXP "
            
624             Case e_EditOptions.eo_Body
626                 commandString = vbNullString
            
628             Case e_EditOptions.eo_Head
630                 commandString = vbNullString
            
632             Case e_EditOptions.eo_CriminalsKilled
634                 commandString = commandString & "CRI "
            
636             Case e_EditOptions.eo_CiticensKilled
638                 commandString = commandString & "CIU "
            
640             Case e_EditOptions.eo_Level
642                 commandString = commandString & "LEVEL "
            
644             Case e_EditOptions.eo_Class
646                 commandString = commandString & "CLASE "
            
648             Case e_EditOptions.eo_Skills
650                 commandString = commandString & "SKILLS "
            
652             Case e_EditOptions.eo_SkillPointsLeft
654                 commandString = commandString & "SKILLSLIBRES "
                
656             Case e_EditOptions.eo_Sex
658                 commandString = commandString & "SEX "
                
660             Case e_EditOptions.eo_Raza
662                 commandString = commandString & "RAZA "

664             Case e_EditOptions.eo_Vida
666                 commandString = commandString & "VIDA "
                    
668             Case e_EditOptions.eo_Mana
670                 commandString = commandString & "MANA "
                    
672             Case e_EditOptions.eo_Energia
674                 commandString = commandString & "ENERGIA "
                    
676             Case e_EditOptions.eo_MinHP
678                 commandString = commandString & "MINHP "
                    
680             Case e_EditOptions.eo_MinMP
682                 commandString = commandString & "MINMP "
                    
684             Case e_EditOptions.eo_Hit
686                 commandString = commandString & "HIT "
                    
688             Case e_EditOptions.eo_MinHit
690                 commandString = commandString & "MINHIT "
                    
692             Case e_EditOptions.eo_MaxHit
694                 commandString = commandString & "MAXHIT "
                    
696             Case e_EditOptions.eo_Desc
698                 commandString = commandString & "DESC "
                    
700             Case e_EditOptions.eo_Intervalo
702                 commandString = commandString & "INTERVALO "
                    
704             Case e_EditOptions.eo_Hogar
706                 commandString = commandString & "HOGAR "
                
                Case e_EditOptions.eo_CASCO
                    commandString = vbNullString
                   
                Case e_EditOptions.eo_Arma
                    commandString = vbNullString
                    
                Case e_EditOptions.eo_Escudo
                    commandString = vbNullString

708             Case Else
710                 commandString = commandString & "UNKOWN "

            End Select
            
            If commandString <> vbNullString Then
714             Call LogGM(.name, commandString & Arg1 & " " & Arg2 & " " & UserName)
            End If
            
        End With

        Exit Sub

ErrHandler:
716     Call TraceError(Err.Number, Err.Description, "Protocol.HandleEditChar", Erl)
718

End Sub

''
' Handles the "RequestCharInfo" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestCharInfo(ByVal userindex As Integer)

        '***************************************************
        'Author: Fredy Horacio Treboux (liquid)
        'Last Modification: 01/08/07
        'Last Modification by: (liquid).. alto bug zapallo..
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
    
            Dim targetName  As String
            Dim TargetIndex As Integer
        
102         targetName = Replace$(Reader.ReadString8(), "+", " ")
104         TargetIndex = NameIndex(targetName)
        
106         If .flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios) Then

                'is the player offline?
108             If TargetIndex > 0 Then

                    'don't allow to retrieve administrator's info
116                 If UserList(TargetIndex).flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios) Then
118                     Call SendUserStatsTxt(userindex, TargetIndex)

                    End If

                End If
            Else
120             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
    
        Exit Sub

ErrHandler:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestCharInfo", Erl)
124

End Sub

''
' Handles the "RequestCharStats" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestCharStats(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
        
            Dim UserName As String
            Dim tUser    As Integer

102         UserName = Reader.ReadString8()
        
104         If (Not .flags.Privilegios And e_PlayerType.RoleMaster) <> 0 And (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) <> 0 Then
106             Call LogGM(.name, "/STAT " & UserName)
            
108             tUser = NameIndex(UserName)
            
110             If tUser > 0 Then

116                 Call SendUserMiniStatsTxt(userindex, tUser)

                End If
            Else
118             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestCharStats", Erl)
122

End Sub

''
' Handles the "RequestCharGold" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestCharGold(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
        
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
104         tUser = NameIndex(UserName)
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
108             Call LogGM(.name, "/BAL " & UserName)
            
110             If tUser > 0 Then

116                 Call WriteConsoleMsg(userindex, "El usuario " & UserName & " tiene " & UserList(tUser).Stats.Banco & " en el banco", e_FontTypeNames.FONTTYPE_TALK)

                End If
            Else
118             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If
        
        End With

        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestCharGold", Erl)
122

End Sub

''
' Handles the "RequestCharInventory" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestCharInventory(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
        
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
104         tUser = NameIndex(UserName)
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
108             Call LogGM(.name, "/INV " & UserName)
            
110             If tUser > 0 Then

116                 Call SendUserInvTxt(userindex, tUser)

                End If
            Else
118             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestCharInventory", Erl)
122

End Sub

''
' Handles the "RequestCharBank" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestCharBank(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
        
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
104         tUser = NameIndex(UserName)
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
108             Call LogGM(.name, "/BOV " & UserName)
            
110             If tUser <= 0 Then
112                 Call WriteConsoleMsg(userindex, "Usuario offline.", e_FontTypeNames.FONTTYPE_TALK)
        
                Else
116                 Call SendUserBovedaTxt(userindex, tUser)

                End If
                
            Else
118             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With

        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestCharBank", Erl)
122

End Sub

''
' Handles the "RequestCharSkills" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRequestCharSkills(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
        
            Dim UserName As String
            Dim tUser    As Integer
            Dim LoopC    As Long
            Dim Message  As String
        
102         UserName = Reader.ReadString8()
104         tUser = NameIndex(UserName)
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
108             Call LogGM(.name, "/STATS " & UserName)
            
110             If tUser <= 0 Then
            
112                 If (InStrB(UserName, "\") <> 0) Then
114                     UserName = Replace(UserName, "\", "")

                    End If

116                 If (InStrB(UserName, "/") <> 0) Then
118                     UserName = Replace(UserName, "/", "")

                    End If
                
120                '  For LoopC = 1 To NUMSKILLS
122                '     Message = Message & "CHAR>" & SkillsNames(LoopC) & " = " & GetVar(CharPath & UserName & ".chr", "SKILLS", "SK" & LoopC) & vbCrLf
124                 'Next LoopC
                
126                ' Call WriteConsoleMsg(UserIndex, Message & "CHAR> Libres:" & GetVar(CharPath & UserName & ".chr", "STATS", "SKILLPTSLIBRES"), e_FontTypeNames.FONTTYPE_INFO)
                
                Else
128                 Call SendUserSkillsTxt(userindex, tUser)

                End If
            Else
130             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
132     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestCharSkills", Erl)
134

End Sub

''
' Handles the "ReviveChar" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleReviveChar(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
        
            Dim UserName As String
            Dim tUser    As Integer
            Dim LoopC    As Byte
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
106             If UCase$(UserName) <> "YO" Then
108                 tUser = NameIndex(UserName)
                Else
110                 tUser = userindex

                End If
            
112             If tUser <= 0 Then
114                 Call WriteConsoleMsg(userindex, "Usuario offline.", e_FontTypeNames.FONTTYPE_INFO)
                Else

116                 With UserList(tUser)

                        'If dead, show him alive (naked).
118                     If .flags.Muerto = 1 Then
                            If UserList(userindex).flags.Privilegios And e_PlayerType.SemiDios Then
                                If MapInfo(.Pos.Map).Seguro = 0 Or EsMapaEvento(.Pos.Map) = False Then
                                     Call WriteConsoleMsg(userindex, "Servidor � No puedes revivir en una zona insegura.", e_FontTypeNames.FONTTYPE_INFO)
                                     Exit Sub
                                End If
                            End If
120                         .flags.Muerto = 0
                        
                            'Call DarCuerpoDesnudo(tUser)
                        
                            'Call ChangeUserChar(tUser, .Char.body, .OrigChar.Head, .Char.heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
122                         Call RevivirUsuario(tUser)
                        
124                         Call WriteConsoleMsg(tUser, UserList(userindex).name & " te ha resucitado.", e_FontTypeNames.FONTTYPE_INFO)
                        Else
126                         Call WriteConsoleMsg(tUser, UserList(userindex).name & " te ha curado.", e_FontTypeNames.FONTTYPE_INFO)

                        End If
                    
128                     .Stats.MinHp = .Stats.MaxHp

                    End With
                
                    ' Call WriteHora(tUser)
130                 Call WriteUpdateHP(tUser)
132                 Call ActualizarVelocidadDeUsuario(tUser)
134                 Call LogGM(.name, "Resucito a " & UserName)
                    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.name & " ha resucitado a " & UserName, e_FontTypeNames.FONTTYPE_INFO))

                End If
            Else
136             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
138     Call TraceError(Err.Number, Err.Description, "Protocol.HandleReviveChar", Erl)
140

End Sub

''
' Handles the "OnlineGM" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleOnlineGM(ByVal userindex As Integer)
        
        On Error GoTo HandleOnlineGM_Err

        '***************************************************
        'Author: Fredy Horacio Treboux (liquid)
        'Last Modification: 12/28/06
        '
        '***************************************************
        Dim i    As Long
        Dim list As String
        Dim priv As e_PlayerType
    
100     With UserList(userindex)
         
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        

106         priv = e_PlayerType.Consejero Or e_PlayerType.SemiDios

108         If .flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin) Then priv = priv Or e_PlayerType.Dios Or e_PlayerType.Admin
        
110         For i = 1 To LastUser

112             If UserList(i).flags.UserLogged Then
114                 If UserList(i).flags.Privilegios And priv Then list = list & UserList(i).name & ", "

                End If

116         Next i
        
118         If LenB(list) <> 0 Then
120             list = Left$(list, Len(list) - 2)
122             Call WriteConsoleMsg(userindex, list & ".", e_FontTypeNames.FONTTYPE_INFO)
            Else
124             Call WriteConsoleMsg(userindex, "No hay GMs Online.", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub

HandleOnlineGM_Err:
126     Call TraceError(Err.Number, Err.Description, "Protocol.HandleOnlineGM", Erl)
128
        
End Sub

''
' Handles the "OnlineMap" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleOnlineMap(ByVal userindex As Integer)
        
        On Error GoTo HandleOnlineMap_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
100     With UserList(userindex)
    
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
        
            Dim LoopC As Long
            Dim list  As String
            Dim priv  As e_PlayerType
        
106         priv = e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios

108         If .flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin) Then priv = priv + (e_PlayerType.Dios Or e_PlayerType.Admin)
        
110         For LoopC = 1 To LastUser

112             If LenB(UserList(LoopC).name) <> 0 And UserList(LoopC).Pos.Map = .Pos.Map Then
114                 If UserList(LoopC).flags.Privilegios And priv Then list = list & UserList(LoopC).name & ", "

                End If

116         Next LoopC
        
118         If Len(list) > 2 Then list = Left$(list, Len(list) - 2)
        
120         Call WriteConsoleMsg(userindex, "Usuarios en el mapa: " & list, e_FontTypeNames.FONTTYPE_INFO)

        End With
        
        Exit Sub

HandleOnlineMap_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleOnlineMap", Erl)
124
        
End Sub

''
' Handles the "Forgive" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleForgive(ByVal userindex As Integer)
        
        On Error GoTo HandleForgive_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
100     With UserList(userindex)
  
            'Se asegura que el target es un npc
102         If .flags.TargetNPC = 0 Then
104             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar al sacerdote.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

            'Validate NPC and make sure player is not dead
106         If (NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Revividor And (NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.ResucitadorNewbie Or Not EsNewbie(userindex))) Or .flags.Muerto = 1 Then Exit Sub
        
            Dim priest As t_Npc
108         priest = NpcList(.flags.TargetNPC)

            'Make sure it's close enough
110         If Distancia(.Pos, priest.Pos) > 3 Then
                'Call WriteLocaleMsg(UserIndex, "8", e_FontTypeNames.FONTTYPE_INFO)
112             Call WriteConsoleMsg(userindex, "El sacerdote no puede escuchar tus pecados debido a que est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
114         If .Faccion.Status = 1 Or .Faccion.ArmadaReal = 1 Then
                'Call WriteLocaleMsg(UserIndex, "8", e_FontTypeNames.FONTTYPE_INFO)
116             Call WriteChatOverHead(userindex, "Tu alma ya esta libre de pecados hijo mio.", priest.Char.CharIndex, vbWhite)
                Exit Sub

            End If
        
118         If .Faccion.FuerzasCaos > 0 Then
120             Call WriteChatOverHead(userindex, "��Dios no te perdonar� mientras seas fiel al Demonio!!", priest.Char.CharIndex, vbWhite)
                Exit Sub

            End If

122         If .GuildIndex <> 0 Then
124             If modGuilds.Alineacion(.GuildIndex) = 1 Then
126                 Call WriteChatOverHead(userindex, "Te encuentras en un clan criminal... debes retirarte para que pueda perdonarte.", priest.Char.CharIndex, vbWhite)
                    Exit Sub

                End If

            End If

128         If .Faccion.ciudadanosMatados > 0 Then
                Dim Donacion As Long
130             Donacion = .Faccion.ciudadanosMatados * OroMult * CostoPerdonPorCiudadano

132             Call WriteChatOverHead(userindex, "Has matado a ciudadanos inocentes, Dios no puede perdonarte lo que has hecho. " & "Pero si haces una generosa donaci�n de, digamos, " & PonerPuntos(Donacion) & " monedas de oro, tal vez cambie de opini�n...", priest.Char.CharIndex, vbWhite)
                Exit Sub

            End If
                        
            Dim permitePerdon As Boolean
            permitePerdon = False
            
            If .GuildIndex > 0 And (GuildAlignmentIndex(.GuildIndex) = e_ALINEACION_GUILD.ALINEACION_CAOTICA Or GuildAlignmentIndex(.GuildIndex) = e_ALINEACION_GUILD.ALINEACION_CRIMINAL) Then
                permitePerdon = False
            Else
                permitePerdon = True
            End If
            
            If Not permitePerdon Then
                Call WriteChatOverHead(userindex, "No podr�s ser perdonado perteneciendo a un clan de alineaci�n Criminal o de Alineaci�n Oscura.", priest.Char.CharIndex, vbYellow)
                Exit Sub
            End If

134         Call WriteChatOverHead(userindex, "Con estas palabras, te libero de todo tipo de pecados. �Que Dios te acompa�e hijo m�o!", priest.Char.CharIndex, vbYellow)

136         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageParticleFX(UserList(userindex).Char.CharIndex, "80", 100, False))
138         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessagePlayWave("100", UserList(userindex).Pos.X, UserList(userindex).Pos.Y))
140         Call VolverCiudadano(userindex)

        End With
        
        Exit Sub

HandleForgive_Err:
142     Call TraceError(Err.Number, Err.Description, "Protocol.HandleForgive", Erl)
144
        
End Sub

''
' Handles the "Kick" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleKick(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
            Dim rank     As Integer
        
102         rank = e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios Or e_PlayerType.Consejero
        
104         UserName = Reader.ReadString8()
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
        
108             tUser = NameIndex(UserName)
            
110             If tUser <= 0 Then
112                 Call WriteConsoleMsg(userindex, "El usuario no esta online.", e_FontTypeNames.FONTTYPE_INFO)
                
                Else

114                 If (UserList(tUser).flags.Privilegios And rank) > (.flags.Privilegios And rank) Then
116                     Call WriteConsoleMsg(userindex, "No podes echar a alguien con jerarquia mayor a la tuya.", e_FontTypeNames.FONTTYPE_INFO)
                    Else
118                     Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.name & " echo a " & UserName & ".", e_FontTypeNames.FONTTYPE_INFO))
120                     Call CloseSocket(tUser)
122                     Call LogGM(.name, "Echo a " & UserName)

                    End If

                End If
            Else
124             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
126     Call TraceError(Err.Number, Err.Description, "Protocol.HandleKick", Erl)
128

End Sub

''
' Handles the "Execute" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleExecute(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
106             tUser = NameIndex(UserName)
            
108             If tUser > 0 Then
 
110                 Call UserDie(tUser)
112                 Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.name & " ha ejecutado a " & UserList(tUser).name, e_FontTypeNames.FONTTYPE_EJECUCION))
114                 Call LogGM(.name, " ejecuto a " & UserName)

                Else
            
116                 Call WriteConsoleMsg(userindex, "No est� online", e_FontTypeNames.FONTTYPE_INFO)

                End If
            Else
118             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleExecute", Erl)
122

End Sub

''
' Handles the "BanChar" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBanChar(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)
  
            Dim UserName As String
            Dim Reason   As String
        
102         UserName = Reader.ReadString8()
104         Reason = Reader.ReadString8()
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
108             Call BanPJ(userindex, UserName, Reason)
            Else
110             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBanChar", Erl)
114

End Sub

''
' Handles the "UnbanChar" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUnbanChar(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
102             UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) Then
            
106             If Not PersonajeExiste(UserName) Then
108                 Call WriteConsoleMsg(userindex, "El personaje no existe.", e_FontTypeNames.FONTTYPE_INFO)
                Else

110                 If BANCheck(UserName) Then
112                     Call SavePenaDatabase(UserName, .name & ": UNBAN. " & Date & " " & Time)
114                     Call UnBanDatabase(UserName)

116                     Call LogGM(.name, "/UNBAN a " & UserName)
118                     Call WriteConsoleMsg(userindex, UserName & " desbaneado.", e_FontTypeNames.FONTTYPE_INFO)
                    Else
120                     Call WriteConsoleMsg(userindex, UserName & " no esta baneado. Imposible desbanear.", e_FontTypeNames.FONTTYPE_INFO)

                    End If

                End If
            Else
122             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
124     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUnbanChar", Erl)
126

End Sub

''
' Handles the "NPCFollow" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleNPCFollow(ByVal userindex As Integer)
        
        On Error GoTo HandleNPCFollow_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
        
106         If .flags.TargetNPC > 0 Then
        
108             Call DoFollow(.flags.TargetNPC, .name)
            
110             NpcList(.flags.TargetNPC).flags.Inmovilizado = 0
112             NpcList(.flags.TargetNPC).flags.Paralizado = 0
114             NpcList(.flags.TargetNPC).Contadores.Paralisis = 0

            End If

        End With
        
        Exit Sub

HandleNPCFollow_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleNPCFollow", Erl)
118
        
End Sub

''
' Handles the "SummonChar" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSummonChar(ByVal userindex As Integer)

    '***************************************************
    'Author: Nicolas Matias Gonzalez (NIGO)
    'Last Modification: 12/29/06
    '
    '***************************************************

    On Error GoTo ErrHandler

100 With UserList(userindex)
    
        Dim UserName As String
        Dim tUser    As Integer
        
102     UserName = Reader.ReadString8()
            
104     If .flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios) Then

           
            
106         If LenB(UserName) <> 0 Then
108             tUser = NameIndex(UserName)

110             If tUser <= 0 Then
112                 Call WriteConsoleMsg(userindex, "El jugador no est� online.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If
                
114         ElseIf .flags.TargetUser > 0 Then
116             tUser = .flags.TargetUser

                ' Mover NPCs
118         ElseIf .flags.TargetNPC > 0 Then

120             If NpcList(.flags.TargetNPC).Pos.Map = .Pos.Map Then
122                 Call WarpNpcChar(.flags.TargetNPC, .Pos.Map, .Pos.X, .Pos.Y + 1, True)
124                 Call WriteConsoleMsg(userindex, "Has desplazado a la criatura.", e_FontTypeNames.FONTTYPE_INFO)
                Else
126                 Call WriteConsoleMsg(userindex, "S�lo puedes mover NPCs dentro del mismo mapa.", e_FontTypeNames.FONTTYPE_INFO)

                End If

                Exit Sub

            Else
                Exit Sub

            End If

            'HarThaos ReyarB creo que aca sacaria comparar Privilegios
128         If CompararPrivilegiosUser(tUser, userindex) > 0 Then
130             Call WriteConsoleMsg(userindex, "Se le ha avisado a " & UserList(tUser).name & " que quieres traerlo a tu posici�n.", e_FontTypeNames.FONTTYPE_INFO)
132             Call WriteConsoleMsg(tUser, .name & " quiere transportarte a su ubicaci�n. Escribe /ira " & .name & " para ir.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
                
            Dim NotConsejero As Boolean
134         NotConsejero = (.flags.Privilegios And e_PlayerType.Consejero) = 0
                
            ' Consejeros s�lo pueden traer en el mismo mapa
136         If NotConsejero Or .Pos.Map = UserList(tUser).Pos.Map Then
                
                 If .flags.Privilegios And (e_PlayerType.SemiDios) Then
                    If Not EsMapaEvento(.Pos.Map) Then 'HarThaos ReyarB hay que sacar eso de mapa seguro y poner mapas de eventos [MapasEventos]
                        Call WriteConsoleMsg(userindex, "Solamente puedes traer usuarios a mapas de evento.", e_FontTypeNames.FONTTYPE_INFO)
                        Exit Sub
                    End If
                    If UserList(tUser).flags.Muerto = 1 Then
                        Call WriteConsoleMsg(userindex, "No puedes transportar a un muerto. ellos tienen /hogar", e_FontTypeNames.FONTTYPE_INFO)
                        Exit Sub
                    End If
                End If
                
                ' Si el admin est� invisible no mostramos el nombre
138             If NotConsejero And .flags.AdminInvisible = 1 Then
140                 Call WriteConsoleMsg(tUser, "Te han trasportado.", e_FontTypeNames.FONTTYPE_INFO)
                Else
142                 Call WriteConsoleMsg(tUser, .name & " te ha trasportado.", e_FontTypeNames.FONTTYPE_INFO)
                End If
                   
                'HarThaoS: Si lo sumonean a un mapa interdimensional desde uno no interdimensional me guardo la posici�n de donde viene.
144             If EsMapaInterdimensional(.Pos.Map) And Not EsMapaInterdimensional(UserList(tUser).Pos.Map) Then
146                 UserList(tUser).flags.ReturnPos = UserList(tUser).Pos
                End If
                        
                        
    
148             Call WarpToLegalPos(tUser, .Pos.Map, .Pos.X, .Pos.Y + 1, True, True)
                Call WriteConsoleMsg(userindex, "Has tra�do a " & UserList(tUser).name & ".", e_FontTypeNames.FONTTYPE_INFO)
152             Call LogGM(.name, "/SUM " & UserName & " Map:" & .Pos.Map & " X:" & .Pos.X & " Y:" & .Pos.Y)
                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.name & " a trasladado a " & UserName, e_FontTypeNames.FONTTYPE_INFO))
                
            End If
        Else
154         Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
        End If

    End With

    Exit Sub
        
ErrHandler:

156 Call TraceError(Err.Number, Err.Description, "Protocol.HandleSummonChar", Erl)
158

End Sub

''
' Handles the "SpawnListRequest" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSpawnListRequest(ByVal userindex As Integer)
        
        On Error GoTo HandleSpawnListRequest_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
100     With UserList(userindex)

102         If .flags.Privilegios And e_PlayerType.user Then
                Exit Sub

104         ElseIf .flags.Privilegios And e_PlayerType.Consejero Then
106             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            
108         ElseIf .flags.Privilegios And (e_PlayerType.SemiDios) Then
110             Call WriteConsoleMsg(userindex, "Servidor � La cantidad de NPCs disponible para tu rango est� limitada.", e_FontTypeNames.FONTTYPE_INFO)
            End If

112         Call WriteSpawnList(userindex, UserList(userindex).flags.Privilegios And e_PlayerType.Admin Or e_PlayerType.Dios)
    
        End With
        
        Exit Sub

HandleSpawnListRequest_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSpawnListRequest", Erl)
116
        
End Sub

''
' Handles the "SpawnCreature" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSpawnCreature(ByVal userindex As Integer)
        
        On Error GoTo HandleSpawnCreature_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim npc As Integer
102             npc = Reader.ReadInt()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
        
106             If npc > 0 And npc <= UBound(Declaraciones.SpawnList()) Then
                    If Declaraciones.SpawnList(npc).NpcName <> "Nada" And (Declaraciones.SpawnList(npc).PuedeInvocar Or (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin)) <> 0) Then
108                     Call SpawnNpc(Declaraciones.SpawnList(npc).NpcIndex, .Pos, True, False)
                    End If
                End If
            
110             Call LogGM(.name, "Sumoneo " & Declaraciones.SpawnList(npc).NpcName)
            Else
112             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
        
        Exit Sub

HandleSpawnCreature_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSpawnCreature", Erl)
116
        
End Sub

''
' Handles the "ResetNPCInventory" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleResetNPCInventory(ByVal userindex As Integer)
        
        On Error GoTo HandleResetNPCInventory_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
100     With UserList(userindex)
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.RoleMaster)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
106         If .flags.TargetNPC = 0 Then Exit Sub
        
108         Call ResetNpcInv(.flags.TargetNPC)
110         Call LogGM(.name, "/RESETINV " & NpcList(.flags.TargetNPC).name)

        End With
        
        Exit Sub

HandleResetNPCInventory_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleResetNPCInventory", Erl)
114
        
End Sub

''
' Handles the "CleanWorld" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCleanWorld(ByVal userindex As Integer)
        
        On Error GoTo HandleCleanWorld_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.RoleMaster)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
            
108         Call WriteConsoleMsg(userindex, "Se han limpiado los items del suelo.", e_FontTypeNames.FONTTYPE_INFO)
            
        End With

        Exit Sub

HandleCleanWorld_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCleanWorld", Erl)
112
        
End Sub

''
' Handles the "ServerMessage" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleServerMessage(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Message As String
102             Message = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
        
106             If LenB(Message) <> 0 Then
108                 Call LogGM(.name, "Mensaje Broadcast:" & Message)
110                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.name & "> " & Message, e_FontTypeNames.FONTTYPE_SERVER))

                End If
            Else
112             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleServerMessage", Erl)
116

End Sub

''
' Handles the "NickToIP" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleNickToIP(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 24/07/07
        'Pablo (ToxicWaste): Agrego para uqe el /nick2ip tambien diga los nicks en esa ip por pedido de la DGM.
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
            Dim priv     As e_PlayerType
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
        
106             tUser = NameIndex(UserName)
108             Call LogGM(.name, "NICK2IP Solicito la IP de " & UserName)

110             If .flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin) Then
112                 priv = e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.Dios Or e_PlayerType.Admin
                
                Else
114                 priv = e_PlayerType.user

                End If
            
116             If tUser > 0 Then
118                 If UserList(tUser).flags.Privilegios And priv Then
                
120                     Call WriteConsoleMsg(userindex, "El ip de " & UserName & " es " & UserList(tUser).IP, e_FontTypeNames.FONTTYPE_INFO)

                        Dim IP    As String
                        Dim lista As String
                        Dim LoopC As Long

122                     IP = UserList(tUser).IP

124                     For LoopC = 1 To LastUser

126                         If UserList(LoopC).IP = IP Then
                        
128                             If LenB(UserList(LoopC).name) <> 0 And UserList(LoopC).flags.UserLogged Then
                            
130                                 If UserList(LoopC).flags.Privilegios And priv Then
132                                     lista = lista & UserList(LoopC).name & ", "
                                    End If

                                End If

                            End If

134                     Next LoopC

136                     If LenB(lista) <> 0 Then lista = Left$(lista, Len(lista) - 2)
                    
138                     Call WriteConsoleMsg(userindex, "Los personajes con ip " & IP & " son: " & lista, e_FontTypeNames.FONTTYPE_INFO)

                    End If

                Else
            
140                 Call WriteConsoleMsg(userindex, "No hay ningun personaje con ese nick", e_FontTypeNames.FONTTYPE_INFO)

                End If
            Else
142             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
144     Call TraceError(Err.Number, Err.Description, "Protocol.HandleNickToIP", Erl)
146

End Sub

''
' Handles the "IPToNick" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleIPToNick(ByVal userindex As Integer)
        
        On Error GoTo HandleIPToNick_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim IP    As String
            Dim LoopC As Long
            Dim lista As String
            Dim priv  As e_PlayerType
        
102         IP = Reader.ReadInt() & "."
104         IP = IP & Reader.ReadInt() & "."
106         IP = IP & Reader.ReadInt() & "."
108         IP = IP & Reader.ReadInt()
        
110         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.RoleMaster)) Then
112             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
114         Call LogGM(.name, "IP2NICK Solicito los Nicks de IP " & IP)
        
116         If .flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin) Then
118             priv = e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.Dios Or e_PlayerType.Admin
            
            Else
120             priv = e_PlayerType.user

            End If

122         For LoopC = 1 To LastUser

124             If UserList(LoopC).IP = IP Then
            
126                 If LenB(UserList(LoopC).name) <> 0 And UserList(LoopC).flags.UserLogged Then
                
128                     If UserList(LoopC).flags.Privilegios And priv Then
130                         lista = lista & UserList(LoopC).name & ", "
                        End If

                    End If

                End If

132         Next LoopC
        
134         If LenB(lista) <> 0 Then lista = Left$(lista, Len(lista) - 2)
        
136         Call WriteConsoleMsg(userindex, "Los personajes con ip " & IP & " son: " & lista, e_FontTypeNames.FONTTYPE_INFO)

        End With
        
        Exit Sub

HandleIPToNick_Err:
138     Call TraceError(Err.Number, Err.Description, "Protocol.HandleIPToNick", Erl)
140
        
End Sub

''
' Handles the "GuildOnlineMembers" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildOnlineMembers(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim GuildName As String
            Dim tGuild    As Integer
        
102         GuildName = Reader.ReadString8()
        
104         If (InStrB(GuildName, "+") <> 0) Then
106             GuildName = Replace(GuildName, "+", " ")
            End If
        
108         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
110             tGuild = GuildIndex(GuildName)
            
112             If tGuild > 0 Then
114                 Call WriteConsoleMsg(userindex, "Clan " & UCase$(GuildName) & ": " & modGuilds.m_ListaDeMiembrosOnline(userindex, tGuild), e_FontTypeNames.FONTTYPE_GUILDMSG)
                End If
            Else
116             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildOnlineMembers", Erl)
120

End Sub

''
' Handles the "TeleportCreate" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleTeleportCreate(ByVal userindex As Integer)
        
        On Error GoTo HandleTeleportCreate_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim Mapa As Integer
            Dim X    As Byte
            Dim Y    As Byte
            Dim Motivo As String
        
102         Mapa = Reader.ReadInt()
104         X = Reader.ReadInt()
106         Y = Reader.ReadInt()
            Motivo = Reader.ReadString8()
        
108         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
110             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
112         Call LogGM(.name, "/CT " & Mapa & "," & X & "," & Y & "," & Motivo)
        
114         If Not MapaValido(Mapa) Or Not InMapBounds(Mapa, X, Y) Then Exit Sub
        
116         If MapData(.Pos.Map, .Pos.X, .Pos.Y - 1).ObjInfo.ObjIndex > 0 Then Exit Sub
        
118         If MapData(.Pos.Map, .Pos.X, .Pos.Y - 1).TileExit.Map > 0 Then Exit Sub
        
120         If MapData(Mapa, X, Y).ObjInfo.ObjIndex > 0 Then
122             Call WriteConsoleMsg(userindex, "Hay un objeto en el piso en ese lugar", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
124         If MapData(Mapa, X, Y).TileExit.Map > 0 Then
126             Call WriteConsoleMsg(userindex, "No pod�s crear un teleport que apunte a la entrada de otro.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
            
            ' Tiene que llevar en zona segura, pueden entrar usuarios sin saber el destino fatal
127         If MapInfo(Mapa).Seguro = 0 Then
                Call WriteConsoleMsg(userindex, "No puedes crear teleport que lleven a mapas inseguros.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

            Dim Objeto As t_Obj
        
128         Objeto.amount = 1
130         Objeto.ObjIndex = 378
        
132         Call MakeObj(Objeto, .Pos.Map, .Pos.X, .Pos.Y - 1)
        
134         With MapData(.Pos.Map, .Pos.X, .Pos.Y - 1)
136             .TileExit.Map = Mapa
138             .TileExit.X = X
140             .TileExit.Y = Y
            End With

        End With
        
        Exit Sub

HandleTeleportCreate_Err:
142     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTeleportCreate", Erl)
144
        
End Sub

''
' Handles the "TeleportDestroy" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleTeleportDestroy(ByVal userindex As Integer)
        
        On Error GoTo HandleTeleportDestroy_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
100     With UserList(userindex)

            Dim Mapa As Integer
            Dim X    As Byte
            Dim Y    As Byte

            '/dt
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
                
106         Mapa = .flags.TargetMap
108         X = .flags.TargetX
110         Y = .flags.TargetY
        
112         If Not InMapBounds(Mapa, X, Y) Then Exit Sub
        
114         With MapData(Mapa, X, Y)

                'Si no tengo objeto y no tengo traslado
116             If .ObjInfo.ObjIndex = 0 And .TileExit.Map = 0 Then Exit Sub
                
                'Si no tengo objeto pero tengo traslado
118             If .ObjInfo.ObjIndex = 0 And .TileExit.Map > 0 Then
120                 Call LogGM(UserList(userindex).name, "/DT: " & Mapa & "," & X & "," & Y)
                
122                 .TileExit.Map = 0
124                 .TileExit.X = 0
126                 .TileExit.Y = 0
                
                    'si tengo objeto y traslado
128             ElseIf .ObjInfo.ObjIndex > 0 And ObjData(.ObjInfo.ObjIndex).OBJType = e_OBJType.otTeleport Then
130                 Call LogGM(UserList(userindex).name, "/DT: " & Mapa & "," & X & "," & Y)
                
132                 Call EraseObj(.ObjInfo.amount, Mapa, X, Y)
                
134                 If MapData(.TileExit.Map, .TileExit.X, .TileExit.Y).ObjInfo.ObjIndex = 651 Then
136                     Call EraseObj(1, .TileExit.Map, .TileExit.X, .TileExit.Y)

                    End If
                
138                 .TileExit.Map = 0
140                 .TileExit.X = 0
142                 .TileExit.Y = 0

                End If

            End With

        End With
        
        Exit Sub

HandleTeleportDestroy_Err:
144     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTeleportDestroy", Erl)
146
        
End Sub

''
' Handles the "RainToggle" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRainToggle(ByVal userindex As Integer)
        
        On Error GoTo HandleRainToggle_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
100     With UserList(userindex)
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
        
106         Call LogGM(.name, "/LLUVIA")
        
108         Lloviendo = Not Lloviendo
110         Nebando = Not Nebando
        
112         Call SendData(SendTarget.ToAll, 0, PrepareMessageRainToggle())
114         Call SendData(SendTarget.ToAll, 0, PrepareMessageNevarToggle())

116         If Lloviendo Then
118             Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayWave(404, NO_3D_SOUND, NO_3D_SOUND)) ' Explota un trueno
120             Call SendData(SendTarget.ToAll, 0, PrepareMessageFlashScreen(&HF5D3F3, 250)) 'Rayo
122             Call ApagarFogatas

            End If

        End With
        
        Exit Sub

HandleRainToggle_Err:
124     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRainToggle", Erl)
126
        
End Sub

''
' Handles the "SetCharDescription" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSetCharDescription(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim tUser As Integer
            Dim Desc  As String
        
102         Desc = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then
        
106             tUser = .flags.TargetUser

108             If tUser > 0 Then
110                 UserList(tUser).DescRM = Desc
                
                Else
112                 Call WriteConsoleMsg(userindex, "Haz click sobre un personaje antes!", e_FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End With

        Exit Sub

ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSetCharDescription", Erl)
116

End Sub

''
' Handles the "ForceMIDIToMap" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HanldeForceMIDIToMap(ByVal userindex As Integer)
        
        On Error GoTo HanldeForceMIDIToMap_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

100     With UserList(userindex)
    
            Dim midiID As Byte
            Dim Mapa   As Integer
        
102         midiID = Reader.ReadInt
104         Mapa = Reader.ReadInt
        
            'Solo dioses, admins y RMS
106         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then

                'Si el mapa no fue enviado tomo el actual
108             If Not InMapBounds(Mapa, 50, 50) Then
110                 Mapa = .Pos.Map
                End If
        
112             If midiID = 0 Then
                    'Ponemos el default del mapa
114                 Call SendData(SendTarget.toMap, Mapa, PrepareMessagePlayMidi(MapInfo(.Pos.Map).music_numberLow))
                
                Else
                    'Ponemos el pedido por el GM
116                 Call SendData(SendTarget.toMap, Mapa, PrepareMessagePlayMidi(midiID))

                End If

            End If

        End With
        
        Exit Sub

HanldeForceMIDIToMap_Err:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HanldeForceMIDIToMap", Erl)
120
        
End Sub

''
' Handles the "ForceWAVEToMap" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleForceWAVEToMap(ByVal userindex As Integer)
        
        On Error GoTo HandleForceWAVEToMap_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
    
100     With UserList(userindex)

            Dim waveID As Byte
            Dim Mapa   As Integer
            Dim X      As Byte
            Dim Y      As Byte
        
102         waveID = Reader.ReadInt()
104         Mapa = Reader.ReadInt()
106         X = Reader.ReadInt()
108         Y = Reader.ReadInt()
        
            'Solo dioses, admins y RMS
110         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then

                'Si el mapa no fue enviado tomo el actual
112             If Not InMapBounds(Mapa, X, Y) Then
            
114                 Mapa = .Pos.Map
116                 X = .Pos.X
118                 Y = .Pos.Y

                End If
            
                'Ponemos el pedido por el GM
120             Call SendData(SendTarget.toMap, Mapa, PrepareMessagePlayWave(waveID, X, Y))

            End If

        End With
        
        Exit Sub

HandleForceWAVEToMap_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleForceWAVEToMap", Erl)
124
        
End Sub

''
' Handles the "RoyalArmyMessage" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRoyalArmyMessage(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Message As String
102             Message = Reader.ReadString8()
        
            'Solo dioses, admins y RMS
104         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then
106             Call SendData(SendTarget.ToRealYRMs, 0, PrepareMessageConsoleMsg("ARMADA REAL> " & Message, e_FontTypeNames.FONTTYPE_TALK))
            End If

        End With

        Exit Sub

ErrHandler:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRoyalArmyMessage", Erl)
110

End Sub

''
' Handles the "ChaosLegionMessage" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleChaosLegionMessage(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Message As String
102             Message = Reader.ReadString8()
        
            'Solo dioses, admins y RMS
104         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then
106             Call SendData(SendTarget.ToCaosYRMs, 0, PrepareMessageConsoleMsg("FUERZAS DEL CAOS> " & Message, e_FontTypeNames.FONTTYPE_TALK))
            End If

        End With

        Exit Sub

ErrHandler:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChaosLegionMessage", Erl)
110

End Sub

''
' Handles the "CitizenMessage" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCitizenMessage(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Message As String
102             Message = Reader.ReadString8()
        
            'Solo dioses, admins y RMS
104         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then
106             Call SendData(SendTarget.ToCiudadanosYRMs, 0, PrepareMessageConsoleMsg("CIUDADANOS> " & Message, e_FontTypeNames.FONTTYPE_TALK))
            End If

        End With

        Exit Sub

ErrHandler:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCitizenMessage", Erl)
110

End Sub

''
' Handles the "CriminalMessage" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCriminalMessage(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Message As String
102             Message = Reader.ReadString8()
        
            'Solo dioses, admins y RMS
104         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then
106             Call SendData(SendTarget.ToCriminalesYRMs, 0, PrepareMessageConsoleMsg("CRIMINALES> " & Message, e_FontTypeNames.FONTTYPE_TALK))
            End If

        End With

        Exit Sub

ErrHandler:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCriminalMessage", Erl)
110

End Sub

''
' Handles the "TalkAsNPC" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleTalkAsNPC(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
        
            Dim Message As String
102             Message = Reader.ReadString8()
        
            'Solo dioses, admins y RMS
104         If (.flags.Privilegios And (e_PlayerType.Dios Or e_PlayerType.Admin Or e_PlayerType.RoleMaster)) Then

                'Asegurarse haya un NPC seleccionado
106             If .flags.TargetNPC > 0 Then
108                 Call SendData(SendTarget.ToNPCArea, .flags.TargetNPC, PrepareMessageChatOverHead(Message, NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite))
                
                Else
110                 Call WriteConsoleMsg(userindex, "Debes seleccionar el NPC por el que quieres hablar antes de usar este comando", e_FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End With

        Exit Sub

ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTalkAsNPC", Erl)
114

End Sub

''
' Handles the "DestroyAllItemsInArea" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleDestroyAllItemsInArea(ByVal userindex As Integer)
        
        On Error GoTo HandleDestroyAllItemsInArea_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
100     With UserList(userindex)
  
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
            Dim X As Long
            Dim Y As Long
        
106         For Y = .Pos.Y - MinYBorder + 1 To .Pos.Y + MinYBorder - 1
108             For X = .Pos.X - MinXBorder + 1 To .Pos.X + MinXBorder - 1

110                 If X > 0 And Y > 0 And X < 101 And Y < 101 Then
                
112                     If MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex > 0 Then
                    
114                         If ItemNoEsDeMapa(MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex) Then
116                             Call EraseObj(MAX_INVENTORY_OBJS, .Pos.Map, X, Y)
                            End If

                        End If

                    End If

118             Next X
120         Next Y
        
122         Call LogGM(UserList(userindex).name, "/MASSDEST")

        End With
        
        Exit Sub

HandleDestroyAllItemsInArea_Err:
124     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDestroyAllItemsInArea", Erl)
126
        
End Sub

''
' Handles the "AcceptRoyalCouncilMember" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleAcceptRoyalCouncilMember(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
    
            Dim UserName As String
            Dim tUser    As Integer
            Dim LoopC    As Byte
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             tUser = NameIndex(UserName)

108             If tUser <= 0 Then
110                 Call WriteConsoleMsg(userindex, "Usuario offline", e_FontTypeNames.FONTTYPE_INFO)
                
                Else
            
112                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserName & " fue aceptado en el honorable Consejo Real de Banderbill.", e_FontTypeNames.FONTTYPE_CONSEJO))

114                 With UserList(tUser)

116                     If .flags.Privilegios And e_PlayerType.ChaosCouncil Then .flags.Privilegios = .flags.Privilegios - e_PlayerType.ChaosCouncil
118                     If Not .flags.Privilegios And e_PlayerType.RoyalCouncil Then .flags.Privilegios = .flags.Privilegios + e_PlayerType.RoyalCouncil
                    
120                     Call WarpUserChar(tUser, .Pos.Map, .Pos.X, .Pos.Y, False)

                    End With

                End If

            End If

        End With

        Exit Sub

ErrHandler:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAcceptRoyalCouncilMember", Erl)
124

End Sub

''
' Handles the "ChaosCouncilMember" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleAcceptChaosCouncilMember(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
            Dim LoopC    As Byte
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             tUser = NameIndex(UserName)

108             If tUser <= 0 Then
110                 Call WriteConsoleMsg(userindex, "Usuario offline", e_FontTypeNames.FONTTYPE_INFO)
                
                Else
            
112                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserName & " fue aceptado en el Consejo de la Legi�n Oscura.", e_FontTypeNames.FONTTYPE_CONSEJO))
                
114                 With UserList(tUser)

116                     If .flags.Privilegios And e_PlayerType.RoyalCouncil Then .flags.Privilegios = .flags.Privilegios - e_PlayerType.RoyalCouncil
118                     If Not .flags.Privilegios And e_PlayerType.ChaosCouncil Then .flags.Privilegios = .flags.Privilegios + e_PlayerType.ChaosCouncil

120                     Call WarpUserChar(tUser, .Pos.Map, .Pos.X, .Pos.Y, False)

                    End With

                End If

            End If

        End With

        Exit Sub

ErrHandler:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAcceptChaosCouncilMember", Erl)
124

End Sub

''
' Handles the "ItemsInTheFloor" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleItemsInTheFloor(ByVal userindex As Integer)
        
        On Error GoTo HandleItemsInTheFloor_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
            Dim tObj  As Integer
            Dim lista As String
            Dim X     As Long
            Dim Y     As Long
        
106         For X = 5 To 95
108             For Y = 5 To 95
110                 tObj = MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex

112                 If tObj > 0 Then
                
114                     If ObjData(tObj).OBJType <> e_OBJType.otArboles Then
116                         Call WriteConsoleMsg(userindex, "(" & X & "," & Y & ") " & ObjData(tObj).name, e_FontTypeNames.FONTTYPE_INFO)
                        End If

                    End If

118             Next Y
120         Next X

        End With
        
        Exit Sub

HandleItemsInTheFloor_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleItemsInTheFloor", Erl)
124
        
End Sub

''
' Handles the "MakeDumb" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleMakeDumb(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
                
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             tUser = NameIndex(UserName)

                'para deteccion de aoice
108             If tUser <= 0 Then
110                 Call WriteConsoleMsg(userindex, "Offline", e_FontTypeNames.FONTTYPE_INFO)
                
                Else
112                 Call WriteDumb(tUser)

                End If

            End If

        End With

        Exit Sub

ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMakeDumb", Erl)
116

End Sub

''
' Handles the "MakeDumbNoMore" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleMakeDumbNoMore(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
    
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             tUser = NameIndex(UserName)

                'para deteccion de aoice
108             If tUser <= 0 Then
110                 Call WriteConsoleMsg(userindex, "Offline", e_FontTypeNames.FONTTYPE_INFO)
                
                Else
112                 Call WriteDumbNoMore(tUser)

                End If

            End If

        End With

        Exit Sub

ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMakeDumbNoMore", Erl)
116

End Sub

''
' Handles the "CouncilKick" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCouncilKick(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
  
        On Error GoTo ErrHandler

100     With UserList(userindex)
 
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             tUser = NameIndex(UserName)

108             If tUser <= 0 Then
110                 If PersonajeExiste(UserName) Then
112                     Call WriteConsoleMsg(userindex, "Usuario offline, echando de los consejos", e_FontTypeNames.FONTTYPE_INFO)

116                     Call EcharConsejoDatabase(UserName)

                    Else
122                     Call WriteConsoleMsg(userindex, "No existe el personaje.", e_FontTypeNames.FONTTYPE_INFO)

                    End If

                Else

124                 With UserList(tUser)

126                     If .flags.Privilegios And e_PlayerType.RoyalCouncil Then
128                         Call WriteConsoleMsg(tUser, "Has sido echado del consejo de Banderbill", e_FontTypeNames.FONTTYPE_TALK)
130                         .flags.Privilegios = .flags.Privilegios - e_PlayerType.RoyalCouncil
                        
132                         Call WarpUserChar(tUser, .Pos.Map, .Pos.X, .Pos.Y)
134                         Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserName & " fue expulsado del consejo de Banderbill", e_FontTypeNames.FONTTYPE_CONSEJO))

                        End If
                    
136                     If .flags.Privilegios And e_PlayerType.ChaosCouncil Then
138                         Call WriteConsoleMsg(tUser, "Has sido echado del consejo de la Legi�n Oscura", e_FontTypeNames.FONTTYPE_TALK)
140                         .flags.Privilegios = .flags.Privilegios - e_PlayerType.ChaosCouncil
                        
142                         Call WarpUserChar(tUser, .Pos.Map, .Pos.X, .Pos.Y)
144                         Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserName & " fue expulsado del consejo de la Legi�n Oscura", e_FontTypeNames.FONTTYPE_CONSEJO))

                        End If

                    End With

                End If

            End If

        End With

        Exit Sub

ErrHandler:
146     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCouncilKick", Erl)
148

End Sub

''
' Handles the "SetTrigger" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleSetTrigger(ByVal userindex As Integer)
        
        On Error GoTo HandleSetTrigger_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************

100     With UserList(userindex)
 
            Dim tTrigger As Byte
            Dim tLog     As String
        
102         tTrigger = Reader.ReadInt()
        
104         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
106         If tTrigger >= 0 Then
        
108             MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = tTrigger
            
110             tLog = "Trigger " & tTrigger & " en mapa " & .Pos.Map & " " & .Pos.X & "," & .Pos.Y
            
112             Call LogGM(.name, tLog)
            
114             Call WriteConsoleMsg(userindex, tLog, e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub

HandleSetTrigger_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSetTrigger", Erl)
118
        
End Sub

''
' Handles the "AskTrigger" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleAskTrigger(ByVal userindex As Integer)
        
        On Error GoTo HandleAskTrigger_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 04/13/07
        '
        '***************************************************
        Dim tTrigger As Byte
    
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
104         tTrigger = MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger
        
106         Call LogGM(.name, "Miro el trigger en " & .Pos.Map & "," & .Pos.X & "," & .Pos.Y & ". Era " & tTrigger)
        
108         Call WriteConsoleMsg(userindex, "Trigger " & tTrigger & " en mapa " & .Pos.Map & " " & .Pos.X & ", " & .Pos.Y, e_FontTypeNames.FONTTYPE_INFO)

        End With
        
        Exit Sub

HandleAskTrigger_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAskTrigger", Erl)
112
        
End Sub

''
' Handles the "BannedIPList" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBannedIPList(ByVal userindex As Integer)
        
    On Error GoTo HandleBannedIPList_Err

100 With UserList(userindex)
102     If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub

        Dim lista As String
        Dim LoopC As Long

104     Call LogGM(.name, "/BANIPLIST")
        
106         For LoopC = 1 To IP_Blacklist.Count
108             lista = lista & IP_Blacklist.Item(LoopC) & ", "
110         Next LoopC

        
112     If LenB(lista) <> 0 Then lista = Left$(lista, Len(lista) - 2)
        
114     Call WriteConsoleMsg(userindex, lista, e_FontTypeNames.FONTTYPE_INFO)

    End With
        
    Exit Sub

HandleBannedIPList_Err:
116 Call TraceError(Err.Number, Err.Description, "Protocol.HandleBannedIPList", Erl)
118
        
End Sub

''
' Handles the "BannedIPReload" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBannedIPReload(ByVal userindex As Integer)
        
    On Error GoTo HandleBannedIPReload_Err

100     With UserList(userindex)
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub

104         Call CargarListaNegraUsuarios
            
106         Call WriteConsoleMsg(userindex, "Lista de IPs recargada.", e_FontTypeNames.FONTTYPE_INFO)
            
    End With
        
    Exit Sub

HandleBannedIPReload_Err:
108 Call TraceError(Err.Number, Err.Description, "Protocol.HandleBannedIPReload", Erl)
110
        
End Sub

''
' Handles the "GuildBan" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleGuildBan(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)
 
            Dim GuildName   As String
            Dim cantMembers As Integer
            Dim LoopC       As Long
            Dim member      As String
            Dim Count       As Byte
            Dim tIndex      As Integer
            Dim tFile       As String
        
102         GuildName = Reader.ReadString8()
        
104         If (Not .flags.Privilegios And e_PlayerType.RoleMaster) <> 0 And (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) Then
106             tFile = App.Path & "\guilds\" & GuildName & "-members.mem"
            
108             If Not FileExist(tFile) Then
110                 Call WriteConsoleMsg(userindex, "No existe el clan: " & GuildName, e_FontTypeNames.FONTTYPE_INFO)
                
                Else
            
112                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.name & " banned al clan " & UCase$(GuildName), e_FontTypeNames.FONTTYPE_FIGHT))
                
                    'baneamos a los miembros
114                 Call LogGM(.name, "BANCLAN a " & UCase$(GuildName))
                
116                 cantMembers = val(GetVar(tFile, "INIT", "NroMembers"))
                
118                 For LoopC = 1 To cantMembers
                        'member es la victima
120                     member = GetVar(tFile, "Members", "Member" & LoopC)
                    
122                     Call Ban(member, "Administracion del servidor", "Clan Banned")
                    
124                     Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("   " & member & "<" & GuildName & "> ha sido expulsado del servidor.", e_FontTypeNames.FONTTYPE_FIGHT))
                    
126                     tIndex = NameIndex(member)

128                     If tIndex > 0 Then
                            'esta online
130                         UserList(tIndex).flags.Ban = 1
132                         Call CloseSocket(tIndex)

                        End If
                    
136                     Call SaveBanDatabase(member, .name & " - BAN AL CLAN: " & GuildName & ". " & Date & " " & Time, .name)


150                 Next LoopC

                End If

            End If

        End With

        Exit Sub

ErrHandler:
152     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGuildBan", Erl)
154

End Sub

''
' Handles the "BanIP" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleBanIP(ByVal userindex As Integer)

        On Error GoTo ErrHandler
    
        Dim tUser As Integer
        Dim bannedip As String
        
100     With UserList(userindex)
        
102         Dim NickOrIP As String: NickOrIP = Reader.ReadString8()
104         Dim Reason As String: Reason = Reader.ReadString8()
        
            ' Si el 4to caracter es un ".", de "XXX.XXX.XXX.XXX", entonces es IP.
106         If mid$(NickOrIP, 4, 1) = "." Then
            
                ' Me fijo que tenga formato valido
108             If IsValidIPAddress(NickOrIP) Then
110                 bannedip = NickOrIP
                Else
112                 Call WriteConsoleMsg(userindex, "La IP " & NickOrIP & " no tiene un formato v�lido.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If
               
            Else ' Es un Nick
        
114             tUser = NameIndex(NickOrIP)
                
116             If tUser <= 0 Then
118                 Call WriteConsoleMsg(userindex, "El personaje no est� online.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                Else
120                 bannedip = UserList(tUser).IP
                End If
            
            End If
         
122         If LenB(bannedip) = 0 Then Exit Sub
        
124         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) = 0 Then
126             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
      
128         If IP_Blacklist.Exists(bannedip) Then
130             Call WriteConsoleMsg(userindex, "La IP " & bannedip & " ya se encuentra en la lista negra de IPs.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
                
132         Call BanearIP(userindex, NickOrIP, bannedip, UserList(userindex).Cuenta)
        
134         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.name & " bane� la IP " & bannedip & " por " & Reason, e_FontTypeNames.FONTTYPE_FIGHT))
        
        
            'Find every player with that ip and ban him!
            Dim i As Long
136         For i = 1 To LastUser

138             If UserList(i).ConnIDValida Then
            
140                 If UserList(i).IP = bannedip Then
                
142                     Call WriteCerrarleCliente(i)
144                     Call CloseSocket(i)
                    
                    End If
                
                End If

146         Next i

        End With

        Exit Sub

ErrHandler:
148     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBanIP", Erl)
150

End Sub

''
' Handles the "UnbanIP" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleUnbanIP(ByVal userindex As Integer)
        
        On Error GoTo HandleUnbanIP_Err

100     With UserList(userindex)
        
            Dim bannedip As String
        
102         bannedip = Reader.ReadInt() & "."
104         bannedip = bannedip & Reader.ReadInt() & "."
106         bannedip = bannedip & Reader.ReadInt() & "."
108         bannedip = bannedip & Reader.ReadInt()
        
110         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) = 0 Then Exit Sub
        
112         If IP_Blacklist.Exists(bannedip) Then
114             Call DesbanearIP(bannedip, userindex)
116             Call WriteConsoleMsg(userindex, "La IP """ & bannedip & """ se ha quitado de la lista de bans.", e_FontTypeNames.FONTTYPE_INFO)
            Else
118             Call WriteConsoleMsg(userindex, "La IP """ & bannedip & """ NO se encuentra en la lista de bans.", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
        
        Exit Sub

HandleUnbanIP_Err:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUnbanIP", Erl)
122
        
End Sub

''
' Handles the "CreateItem" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleCreateItem(ByVal userindex As Integer)
        
        On Error GoTo HandleCreateItem_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
100     With UserList(userindex)

            Dim tObj    As Integer
            Dim Cuantos As Integer
        
102         tObj = Reader.ReadInt()
104         Cuantos = Reader.ReadInt()
    
            ' Si es usuario, lo sacamos cagando.
106         If Not EsGM(userindex) Or (.flags.Privilegios And e_PlayerType.Consejero) Then Exit Sub
        
            ' Si es Semi-Dios, dejamos crear un item siempre y cuando pueda estar en el inventario.
108         If (.flags.Privilegios And e_PlayerType.SemiDios) <> 0 And ObjData(tObj).Agarrable = 1 Then Exit Sub

            ' Si hace mas de 10000, lo sacamos cagando.
110         If Cuantos > MAX_INVENTORY_OBJS Then
112             Call WriteConsoleMsg(userindex, "Solo pod�s crear hasta " & CStr(MAX_INVENTORY_OBJS) & " unidades", e_FontTypeNames.FONTTYPE_TALK)
                Exit Sub

            End If
        
            ' El indice proporcionado supera la cantidad minima o total de items existentes en el juego?
114         If tObj < 1 Or tObj > NumObjDatas Then Exit Sub
        
            ' El nombre del objeto es nulo?
116         If LenB(ObjData(tObj).name) = 0 Then Exit Sub
        
            Dim Objeto As t_Obj
118         Objeto.amount = Cuantos
120         Objeto.ObjIndex = tObj

            ' Chequeo si el objeto es AGARRABLE(para las puertas, arboles y demAs t_Objs. que no deberian estar en el inventario)
            '   0 = SI
            '   1 = NO
122         If ObjData(tObj).Agarrable = 0 Then
            
                ' Trato de meterlo en el inventario.
124             If MeterItemEnInventario(userindex, Objeto) Then
126                 Call WriteConsoleMsg(userindex, "Has creado " & Objeto.amount & " unidades de " & ObjData(tObj).name & ".", e_FontTypeNames.FONTTYPE_INFO)
            
                Else

128                 Call WriteConsoleMsg(userindex, "No tenes espacio en tu inventario para crear el item.", e_FontTypeNames.FONTTYPE_INFO)
                
                    ' Si no hay espacio y es Dios o Admin, lo tiro al piso.
130                 If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) <> 0 Then
132                     Call TirarItemAlPiso(.Pos, Objeto)
134                     Call WriteConsoleMsg(userindex, "ATENCION: CREASTE [" & Cuantos & "] ITEMS, TIRE E INGRESE /DEST EN CONSOLA PARA DESTRUIR LOS QUE NO NECESITE!!", e_FontTypeNames.FONTTYPE_GUILD)

                    End If
                
                End If
        
            Else
        
                ' Crear el item NO AGARRARBLE y tirarlo al piso.
                ' Si no hay espacio y es Dios o Admin, lo tiro al piso.
136             If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) <> 0 Then
138                 Call TirarItemAlPiso(.Pos, Objeto)
140                 Call WriteConsoleMsg(userindex, "ATENCION: CREASTE [" & Cuantos & "] ITEMS, TIRE E INGRESE /DEST EN CONSOLA PARA DESTRUIR LOS QUE NO NECESITE!!", e_FontTypeNames.FONTTYPE_GUILD)

                End If

            End If
        
            ' Lo registro en los logs.
            If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) <> 0 Then
142             Call LogGM(.name, "/CI: " & tObj & " Cantidad : " & Cuantos)
            End If

        End With
        
        Exit Sub

HandleCreateItem_Err:
144     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCreateItem", Erl)
146
        
End Sub

''
' Handles the "DestroyItems" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleDestroyItems(ByVal userindex As Integer)
        
        On Error GoTo HandleDestroyItems_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
        
106         If MapData(.Pos.Map, .Pos.X, .Pos.Y).ObjInfo.ObjIndex = 0 Then Exit Sub
        
108         Call LogGM(.name, "/DEST")

110         Call EraseObj(MAX_INVENTORY_OBJS, .Pos.Map, .Pos.X, .Pos.Y)

        End With
        
        Exit Sub

HandleDestroyItems_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDestroyItems", Erl)
114
        
End Sub

''
' Handles the "ChaosLegionKick" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleChaosLegionKick(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)
 
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             If (InStrB(UserName, "\") <> 0) Then
108                 UserName = Replace(UserName, "\", "")

                End If

110             If (InStrB(UserName, "/") <> 0) Then
112                 UserName = Replace(UserName, "/", "")

                End If

114             tUser = NameIndex(UserName)
            
116             Call LogGM(.name, "ECHO DEL CAOS A: " & UserName)
    
118             If tUser > 0 Then
120                 UserList(tUser).Faccion.FuerzasCaos = 0
122                 UserList(tUser).Faccion.Reenlistadas = 200
124                 Call WriteConsoleMsg(userindex, UserName & " expulsado de las fuerzas del caos y prohibida la reenlistada", e_FontTypeNames.FONTTYPE_INFO)
126                 Call WriteConsoleMsg(tUser, .name & " te ha expulsado en forma definitiva de las fuerzas del caos.", e_FontTypeNames.FONTTYPE_FIGHT)
                
                Else

128                 If PersonajeExiste(UserName) Then
132                     Call EcharLegionDatabase(UserName)
 
140                     Call WriteConsoleMsg(userindex, UserName & " expulsado de las fuerzas del caos y prohibida la reenlistada", e_FontTypeNames.FONTTYPE_INFO)
                    Else
142                     Call WriteConsoleMsg(userindex, "El personaje " & UserName & " no existe.", e_FontTypeNames.FONTTYPE_INFO)

                    End If

                End If

            End If

        End With

        Exit Sub

ErrHandler:
144     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChaosLegionKick", Erl)
146

End Sub

''
' Handles the "RoyalArmyKick" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRoyalArmyKick(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
        
106             If (InStrB(UserName, "\") <> 0) Then
108                 UserName = Replace(UserName, "\", "")
                End If

110             If (InStrB(UserName, "/") <> 0) Then
112                 UserName = Replace(UserName, "/", "")
                End If

114             tUser = NameIndex(UserName)
            
116             Call LogGM(.name, "ECHO DE LA REAL A: " & UserName)
            
118             If tUser > 0 Then
            
120                 UserList(tUser).Faccion.ArmadaReal = 0
122                 UserList(tUser).Faccion.Reenlistadas = 200
                
124                 Call WriteConsoleMsg(userindex, UserName & " expulsado de las fuerzas reales y prohibida la reenlistada", e_FontTypeNames.FONTTYPE_INFO)
126                 Call WriteConsoleMsg(tUser, .name & " te ha expulsado en forma definitiva de las fuerzas reales.", e_FontTypeNames.FONTTYPE_FIGHT)
                
                Else

128                 If PersonajeExiste(UserName) Then

132                     Call EcharArmadaDatabase(UserName)

140                     Call WriteConsoleMsg(userindex, UserName & " expulsado de las fuerzas reales y prohibida la reenlistada", e_FontTypeNames.FONTTYPE_INFO)
                    
                    Else
142                     Call WriteConsoleMsg(userindex, UserName & " inexistente.", e_FontTypeNames.FONTTYPE_INFO)

                    End If

                End If

            End If

        End With

        Exit Sub

ErrHandler:
144     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRoyalArmyKick", Erl)
146

End Sub

''
' Handles the "ForceMIDIAll" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleForceMIDIAll(ByVal userindex As Integer)
        
        On Error GoTo HandleForceMIDIAll_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim midiID As Byte
102             midiID = Reader.ReadInt()
        
104         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
106             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
108         Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.name & " broadcast musica: " & midiID, e_FontTypeNames.FONTTYPE_SERVER))
110         Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayMidi(midiID))

        End With
        
        Exit Sub

HandleForceMIDIAll_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleForceMIDIAll", Erl)
114
        
End Sub

''
' Handles the "ForceWAVEAll" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleForceWAVEAll(ByVal userindex As Integer)
        
        On Error GoTo HandleForceWAVEAll_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
    
100     With UserList(userindex)

            Dim waveID As Byte
102             waveID = Reader.ReadInt()
        
104         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
106             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
108         Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayWave(waveID, NO_3D_SOUND, NO_3D_SOUND))

        End With
        
        Exit Sub

HandleForceWAVEAll_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleForceWAVEAll", Erl)
112
        
End Sub

''
' Handles the "RemovePunishment" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleRemovePunishment(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 1/05/07
        'Pablo (ToxicWaste): 1/05/07, You can now edit the punishment.
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName   As String
            Dim punishment As Byte
            Dim NewText    As String
        
102         UserName = Reader.ReadString8()
104         punishment = Reader.ReadInt
106         NewText = Reader.ReadString8()
        
108         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
        
110             If LenB(UserName) = 0 Then
112                 Call WriteConsoleMsg(userindex, "Utilice /borrarpena Nick@NumeroDePena@NuevaPena", e_FontTypeNames.FONTTYPE_INFO)
                
                Else

114                 If (InStrB(UserName, "\") <> 0) Then
116                     UserName = Replace(UserName, "\", "")

                    End If

118                 If (InStrB(UserName, "/") <> 0) Then
120                     UserName = Replace(UserName, "/", "")

                    End If
                
122                 If PersonajeExiste(UserName) Then
124                     Call LogGM(.name, "Borro la pena " & punishment & " de " & UserName & " y la cambi� por: " & NewText)

128                     Call CambiarPenaDatabase(UserName, punishment, .name & ": <" & NewText & "> " & Date & " " & Time)

132                     Call WriteConsoleMsg(userindex, "Pena Modificada.", e_FontTypeNames.FONTTYPE_INFO)

                    End If

                End If

            End If

        End With

        Exit Sub

ErrHandler:
134     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRemovePunishment", Erl)
136

End Sub

''
' Handles the "Tile_BlockedToggle" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleTile_BlockedToggle(ByVal userindex As Integer)
        
        On Error GoTo HandleTile_BlockedToggle_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
100     With UserList(userindex)
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        

106         Call LogGM(.name, "/BLOQ")
        
108         If MapData(.Pos.Map, .Pos.X, .Pos.Y).Blocked = 0 Then
110             MapData(.Pos.Map, .Pos.X, .Pos.Y).Blocked = e_Block.ALL_SIDES Or e_Block.GM
            
            Else
112             MapData(.Pos.Map, .Pos.X, .Pos.Y).Blocked = 0

            End If
        
114         Call Bloquear(True, .Pos.Map, .Pos.X, .Pos.Y, IIf(MapData(.Pos.Map, .Pos.X, .Pos.Y).Blocked > 0, e_Block.ALL_SIDES, 0))

        End With
        
        Exit Sub

HandleTile_BlockedToggle_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTile_BlockedToggle", Erl)
118
        
End Sub

''
' Handles the "KillNPCNoRespawn" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleKillNPCNoRespawn(ByVal userindex As Integer)
        
        On Error GoTo HandleKillNPCNoRespawn_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/30/06
        '
        '***************************************************
100     With UserList(userindex)

            If Not EsGM(userindex) Then Exit Sub

102         If .flags.Privilegios And e_PlayerType.Consejero Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
        
106         If .flags.TargetNPC = 0 Then Exit Sub
        
108         Call QuitarNPC(.flags.TargetNPC)
        
110         Call LogGM(.name, "/MATA " & NpcList(.flags.TargetNPC).name)

        End With
        
        Exit Sub

HandleKillNPCNoRespawn_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleKillNPCNoRespawn", Erl)
114
        
End Sub

''
' Handles the "KillAllNearbyNPCs" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleKillAllNearbyNPCs(ByVal userindex As Integer)
        
        On Error GoTo HandleKillAllNearbyNPCs_Err

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 07/07/2021
        'ReyarB
        '***************************************************
100     With UserList(userindex)

            If Not EsGM(userindex) Then Exit Sub
        
102         If (.flags.Privilegios And (e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
            Dim X As Long
            Dim Y As Long
        
108         For Y = .Pos.Y - MinYBorder + 1 To .Pos.Y + MinYBorder - 1
110             For X = .Pos.X - MinXBorder + 1 To .Pos.X + MinXBorder - 1

112                 If X > 0 And Y > 0 And X < 101 And Y < 101 Then

114                     If MapData(.Pos.Map, X, Y).NpcIndex > 0 Then
                    
116                         Call QuitarNPC(MapData(.Pos.Map, X, Y).NpcIndex)

                        End If

                    End If

118             Next X
120         Next Y

122         Call LogGM(.name, "/MASSKILL")

        End With
        
        Exit Sub

HandleKillAllNearbyNPCs_Err:
124     Call TraceError(Err.Number, Err.Description, "Protocol.HandleKillAllNearbyNPCs", Erl)
126
        
End Sub

''
' Handles the "LastIP" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleLastIP(ByVal userindex As Integer)

        '***************************************************
        'Author: Mart�n Trionfetti (HarThaoS) - Fernando Quinteros (Lord Fers)
        'Last Modification: 15-11-2021
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName   As String
            Dim LoopC      As Byte
        
104         UserName = Reader.ReadString8()
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) Then

                'Handle special chars
108             If (InStrB(UserName, "\") <> 0) Then
110                 UserName = Replace(UserName, "\", "")
                End If

112             If (InStrB(UserName, "\") <> 0) Then
114                 UserName = Replace(UserName, "/", "")
                End If

116             If (InStrB(UserName, "+") <> 0) Then
118                 UserName = Replace(UserName, "+", " ")
                End If
                
                Dim tIndex As Integer
                
                tIndex = NameIndex(UserName)
                
                Dim RS As ADODB.Recordset
                Dim ipStr As String
                
120             If tIndex > 0 Then
122                 Call LogGM(.name, "/LASTIP " & UserName)
                    
                    Set RS = Query("SELECT last_ip FROM account WHERE id = ?", UserList(tIndex).AccountID)
            
                    'Revisamos si recibio un resultado
                    If RS Is Nothing Then Exit Sub
                    If RS.BOF Or RS.EOF Then Exit Sub
                    
                    'Obtenemos la variable
                    ipStr = RS.Fields(0).Value
                Else
                    Dim account_id As String
                    Set RS = Query("SELECT u.account_id FROM user u WHERE LOWER(u.name) = LOWER(?)", UserName)
                    
                    'Revisamos si recibio un resultado
                    If RS Is Nothing Then Exit Sub
                    If RS.BOF Or RS.EOF Then Exit Sub
                    
                    'Obtenemos la variable
                    account_id = RS.Fields(0).Value
                    
                    Set RS = Query("SELECT last_ip FROM account WHERE id = ?", account_id)
            
                    'Revisamos si recibio un resultado
                    If RS Is Nothing Then Exit Sub
                    If RS.BOF Or RS.EOF Then Exit Sub
                    
                    'Obtenemos la variable
                    ipStr = RS.Fields(0).Value
                End If
                Dim countIps As Long
                countIps = UBound(Split(ipStr, ";"))
                
                If countIps <= 0 Then Exit Sub
                
                ReDim ip_list(0 To (countIps - 1)) As String
                ip_list = Split(ipStr, ";")
                Call WriteConsoleMsg(userindex, "Las �ltimas ips para el personaje son: ", e_FontTypeNames.FONTTYPE_INFO)
                For LoopC = 0 To (countIps - 1)
                    Call WriteConsoleMsg(userindex, ip_list(LoopC), e_FontTypeNames.FONTTYPE_INFO)
                Next LoopC
            Else
146             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
148     Call TraceError(Err.Number, Err.Description, "Protocol.HandleLastIP", Erl)
150

End Sub

''
' Handles the "ChatColor" message.
'
' @param    UserIndex The index of the user sending the message.

Public Sub HandleChatColor(ByVal userindex As Integer)
        
        On Error GoTo HandleChatColor_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Last modified by: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Change the user`s chat color
        '***************************************************

100     With UserList(userindex)

            Dim Color As Long
102             Color = RGB(Reader.ReadInt(), Reader.ReadInt(), Reader.ReadInt())
        
104         If EsGM(userindex) Then
106             .flags.ChatColor = Color
            End If

        End With
        
        Exit Sub

HandleChatColor_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChatColor", Erl)
110
        
End Sub

''
' Handles the "Ignored" message.
'
' @param    UserIndex The index of the user sending the message.

Public Sub HandleIgnored(ByVal userindex As Integer)
        
        On Error GoTo HandleIgnored_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Ignore the user
        '***************************************************
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios Or e_PlayerType.Consejero)) Then
104             .flags.AdminPerseguible = Not .flags.AdminPerseguible
            End If

        End With
        
        Exit Sub

HandleIgnored_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleIgnored", Erl)
108
        
End Sub

''
' Handles the "CheckSlot" message.
'
' @param    UserIndex The index of the user sending the message.

Public Sub HandleCheckSlot(ByVal userindex As Integer)

        '***************************************************
        'Author: Pablo (ToxicWaste)
        'Last Modification: 26/01/2007
        'Check one Users Slot in Particular from Inventory
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            'Reads the UserName and Slot Packets
            Dim UserName As String
            Dim Slot     As Byte
            Dim tIndex   As Integer
        
102         UserName = Reader.ReadString8() 'Que UserName?
104         Slot = Reader.ReadInt() 'Que Slot?
106         tIndex = NameIndex(UserName)  'Que user index?

108         If Not EsGM(userindex) Then Exit Sub
        
110         Call LogGM(.name, .name & " Checkeo el slot " & Slot & " de " & UserName)
           
112         If tIndex > 0 Then
114             If Slot > 0 And Slot <= UserList(userindex).CurrentInventorySlots Then
            
116                 If UserList(tIndex).Invent.Object(Slot).ObjIndex > 0 Then
118                     Call WriteConsoleMsg(userindex, " Objeto " & Slot & ") " & ObjData(UserList(tIndex).Invent.Object(Slot).ObjIndex).name & " Cantidad:" & UserList(tIndex).Invent.Object(Slot).amount, e_FontTypeNames.FONTTYPE_INFO)
                    Else
120                     Call WriteConsoleMsg(userindex, "No hay Objeto en slot seleccionado", e_FontTypeNames.FONTTYPE_INFO)

                    End If

                Else
122                 Call WriteConsoleMsg(userindex, "Slot Inv�lido.", e_FontTypeNames.FONTTYPE_TALK)

                End If

            Else
124             Call WriteConsoleMsg(userindex, "Usuario offline.", e_FontTypeNames.FONTTYPE_TALK)

            End If

        End With
    
        Exit Sub

ErrHandler:
126     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCheckSlot", Erl)
128

End Sub


''
' Handles the "ReloadObjects" message.
'
' @param    UserIndex The index of the user sending the message.

Public Sub HandleReloadObjects(ByVal userindex As Integer)
        
        On Error GoTo HandleReloadObjects_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Reload the objects
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
104         Call LogGM(.name, .name & " ha recargado a los objetos.")
        
106         Call LoadOBJData
108         Call LoadPesca
110         Call LoadRecursosEspeciales
112         Call WriteConsoleMsg(userindex, "Obj.dat recargado exitosamente.", e_FontTypeNames.FONTTYPE_SERVER)

        End With
        
        Exit Sub

HandleReloadObjects_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleReloadObjects", Erl)
116
        
End Sub

''
' Handles the "ReloadSpells" message.
'
' @param    UserIndex The index of the user sending the message.

Public Sub HandleReloadSpells(ByVal userindex As Integer)
        
        On Error GoTo HandleReloadSpells_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Reload the spells
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
104         Call LogGM(.name, .name & " ha recargado los hechizos.")
        
106         Call CargarHechizos

        End With
        
        Exit Sub

HandleReloadSpells_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleReloadSpells", Erl)
110
        
End Sub

''
' Handle the "ReloadServerIni" message.
'
' @param UserIndex The index of the user sending the message

Public Sub HandleReloadServerIni(ByVal userindex As Integer)
        
        On Error GoTo HandleReloadServerIni_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Reload the Server`s INI
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
104         Call LogGM(.name, .name & " ha recargado los INITs.")
        
106         Call LoadSini
            Call LoadMD5

        End With
        
        Exit Sub

HandleReloadServerIni_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleReloadServerIni", Erl)
110
        
End Sub

''
' Handle the "ReloadNPCs" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleReloadNPCs(ByVal userindex As Integer)
        
        On Error GoTo HandleReloadNPCs_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Reload the Server`s NPC
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
         
104         Call LogGM(.name, .name & " ha recargado los NPCs.")
    
106         Call CargaNpcsDat
    
108         Call WriteConsoleMsg(userindex, "Npcs.dat recargado exitosamente.", e_FontTypeNames.FONTTYPE_SERVER)

        End With
        
        Exit Sub

HandleReloadNPCs_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleReloadNPCs", Erl)
112
        
End Sub

''
' Handle the "KickAllChars" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleKickAllChars(ByVal userindex As Integer)
        
        On Error GoTo HandleKickAllChars_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Kick all the chars that are online
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
104         Call LogGM(.name, .name & " ha echado a todos los personajes.")
        
106         Call EcharPjsNoPrivilegiados

        End With
        
        Exit Sub

HandleKickAllChars_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleKickAllChars", Erl)
110
        
End Sub

''
' Handle the "Night" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleNight(ByVal userindex As Integer)
        
        On Error GoTo HandleNight_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Last modified by: Juan Mart�n Sotuyo Dodero (Maraxus)
        '
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

106         HoraMundo = GetTickCount()

108         Call SendData(SendTarget.ToAll, 0, PrepareMessageHora())
    
        End With
        
        Exit Sub

HandleNight_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleNight", Erl)
112
        
End Sub

''
' Handle the "Day" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleDay(ByVal userindex As Integer)
        
        On Error GoTo HandleDay_Err

100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

106         HoraMundo = GetTickCount() - DuracionDia \ 2

108         Call SendData(SendTarget.ToAll, 0, PrepareMessageHora())
    
        End With
        
        Exit Sub

HandleDay_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDay", Erl)
112
        
End Sub

''
' Handle the "SetTime" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleSetTime(ByVal userindex As Integer)
        
        On Error GoTo HandleSetTime_Err

100     With UserList(userindex)
        
        

            Dim HoraDia As Long
102         HoraDia = Reader.ReadInt
        
104         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then
106             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

108         HoraMundo = GetTickCount() - HoraDia
            
110         Call SendData(SendTarget.ToAll, 0, PrepareMessageHora())
    
        End With
        
        Exit Sub

HandleSetTime_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSetTime", Erl)
114
        
End Sub

Public Sub HandleDonateGold(ByVal userindex As Integer)
        
        On Error GoTo handle

100     With UserList(userindex)
        
        

            Dim Oro As Long
102         Oro = Reader.ReadInt

104         If Oro <= 0 Then Exit Sub

            'Se asegura que el target es un npc
106         If .flags.TargetNPC = 0 Then
108             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar al sacerdote.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            Dim priest As t_Npc
110         priest = NpcList(.flags.TargetNPC)

            'Validate NPC is an actual priest and the player is not dead
112         If (priest.NPCtype <> e_NPCType.Revividor And (priest.NPCtype <> e_NPCType.ResucitadorNewbie Or Not EsNewbie(userindex))) Or .flags.Muerto = 1 Then Exit Sub

            'Make sure it's close enough
114         If Distancia(.Pos, NpcList(.flags.TargetNPC).Pos) > 3 Then
116             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

118         If .Faccion.Status = 1 Or .Faccion.ArmadaReal = 1 Or .Faccion.FuerzasCaos > 0 Or .Faccion.ciudadanosMatados = 0 Then
120             Call WriteChatOverHead(userindex, "No puedo aceptar tu donaci�n en este momento...", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                Exit Sub

            End If

122         If .GuildIndex <> 0 Then
124             If modGuilds.Alineacion(.GuildIndex) = 1 Then
126                 Call WriteChatOverHead(userindex, "Te encuentras en un clan criminal... no puedo aceptar tu donaci�n.", priest.Char.CharIndex, vbWhite)
                    Exit Sub

                End If

            End If

128         If .Stats.GLD < Oro Then
130             Call WriteConsoleMsg(userindex, "No tienes suficiente dinero.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

            Dim Donacion As Long
132         Donacion = .Faccion.ciudadanosMatados * OroMult * CostoPerdonPorCiudadano

134         If Oro < Donacion Then
136             Call WriteChatOverHead(userindex, "Dios no puede perdonarte si eres una persona avara.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                Exit Sub

            End If

138         .Stats.GLD = .Stats.GLD - Oro

140         Call WriteUpdateGold(userindex)

142         Call WriteConsoleMsg(userindex, "Has donado " & PonerPuntos(Oro) & " monedas de oro.", e_FontTypeNames.FONTTYPE_INFO)

144         Call WriteChatOverHead(userindex, "�Gracias por tu generosa donaci�n! Con estas palabras, te libero de todo tipo de pecados. �Que Dios te acompa�e hijo m�o!", NpcList(UserList(userindex).flags.TargetNPC).Char.CharIndex, vbYellow)

146         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageParticleFX(UserList(userindex).Char.CharIndex, "80", 100, False))
148         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessagePlayWave("100", UserList(userindex).Pos.X, UserList(userindex).Pos.Y))
150         Call VolverCiudadano(userindex)
    
        End With
        
        Exit Sub

handle:
152     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDonateGold", Erl)
154
        
End Sub

Public Sub HandlePromedio(ByVal userindex As Integer)
        
        On Error GoTo handle

100     With UserList(userindex)

102         Call WriteConsoleMsg(userindex, ListaClases(.clase) & " " & ListaRazas(.raza) & " nivel " & .Stats.ELV & ".", FONTTYPE_INFOBOLD)
            
            Dim Promedio As Double, Vida As Long
        
104         Promedio = ModClase(.clase).Vida - (21 - .Stats.UserAtributos(e_Atributos.Constitucion)) * 0.5
106         Vida = 18 + ModRaza(.raza).Constitucion + Promedio * (.Stats.ELV - 1)

108         Call WriteConsoleMsg(userindex, "Vida esperada: " & Vida & ". Promedio: " & Promedio, FONTTYPE_INFOBOLD)

110         Promedio = CalcularPromedioVida(userindex)

            Dim Diff As Long, Color As e_FontTypeNames, Signo As String
            
112         Diff = .Stats.MaxHp - Vida
            
114         If Diff < 0 Then
116             Color = FONTTYPE_PROMEDIO_MENOR
118             Signo = "-"

120         ElseIf Diff > 0 Then
122             Color = FONTTYPE_PROMEDIO_MAYOR
124             Signo = "+"

            Else
126             Color = FONTTYPE_PROMEDIO_IGUAL
128             Signo = "+"
                
            End If

130         Call WriteConsoleMsg(userindex, "Vida actual: " & .Stats.MaxHp & " (" & Signo & Abs(Diff) & "). Promedio: " & Round(Promedio, 2), Color)

        End With
        
        Exit Sub

handle:
132     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePromedio", Erl)
134
        
End Sub

Public Sub HandleGiveItem(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim ObjIndex As Integer
            Dim Cantidad As Integer
            Dim Motivo   As String
            Dim tIndex   As Integer
        
102         UserName = Reader.ReadString8()
104         ObjIndex = Reader.ReadInt()
106         Cantidad = Reader.ReadInt()
108         Motivo = Reader.ReadString8()
        
110         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) Then

112             If ObjData(ObjIndex).Agarrable = 1 Then Exit Sub

114             If Cantidad > MAX_INVENTORY_OBJS Then Cantidad = MAX_INVENTORY_OBJS

                ' El indice proporcionado supera la cantidad minima o total de items existentes en el juego?
116             If ObjIndex < 1 Or ObjIndex > NumObjDatas Then Exit Sub
            
                ' El nombre del objeto es nulo?
118             If LenB(ObjData(ObjIndex).name) = 0 Then Exit Sub

                ' Est� online?
120             tIndex = NameIndex(UserName)

122             If tIndex = 0 Then
124                 Call WriteConsoleMsg(userindex, "El usuario " & UserName & " no est� conectado.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If

                Dim Objeto As t_Obj
126             Objeto.amount = Cantidad
128             Objeto.ObjIndex = ObjIndex

                ' Trato de meterlo en el inventario.
130             If MeterItemEnInventario(tIndex, Objeto) Then
132                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.name & " ha otorgado a " & UserList(tIndex).name & " " & Cantidad & " " & ObjData(ObjIndex).name & ": " & Motivo, e_FontTypeNames.FONTTYPE_ROSA))
                Else
134                 Call WriteConsoleMsg(userindex, "El usuario no tiene espacio en el inventario.", e_FontTypeNames.FONTTYPE_INFO)

                End If

                ' Lo registro en los logs.
136             Call LogGM(.name, "/DAR " & UserName & " - Item: " & ObjData(ObjIndex).name & "(" & ObjIndex & ") Cantidad : " & Cantidad)
138             Call LogPremios(.name, UserName, ObjIndex, Cantidad, Motivo)
            Else
140             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo, debes pedir a un Dios que lo de.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
142     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGiveItem", Erl)
144
        
End Sub

''
' Handle the "ShowServerForm" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleShowServerForm(ByVal userindex As Integer)
        
        On Error GoTo HandleShowServerForm_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Show the server form
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
104         Call LogGM(.name, .name & " ha solicitado mostrar el formulario del servidor.")
106         Call frmMain.mnuMostrar_Click

        End With
        
        Exit Sub

HandleShowServerForm_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleShowServerForm", Erl)
110
        
End Sub

''
' Handle the "CleanSOS" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleCleanSOS(ByVal userindex As Integer)
        
        On Error GoTo HandleCleanSOS_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Clean the SOS
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
104         Call LogGM(.name, .name & " ha borrado los SOS")
        
106         Call Ayuda.Reset

        End With
        
        Exit Sub

HandleCleanSOS_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCleanSOS", Erl)
110
        
End Sub

''
' Handle the "SaveChars" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleSaveChars(ByVal userindex As Integer)
        
        On Error GoTo HandleSaveChars_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/23/06
        'Save the characters
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.RoleMaster)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
106         Call LogGM(.name, .name & " ha guardado todos los chars")
        
108         Call GuardarUsuarios

        End With
        
        Exit Sub

HandleSaveChars_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSaveChars", Erl)
112
        
End Sub

''
' Handle the "ChangeMapInfoBackup" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMapInfoBackup(ByVal userindex As Integer)
        
        On Error GoTo HandleChangeMapInfoBackup_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/24/06
        'Last modified by: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Change the backup`s info of the map
        '***************************************************

100     With UserList(userindex)

            Dim doTheBackUp As Boolean
        
102         doTheBackUp = Reader.ReadBool()
        
104         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
106         Call LogGM(.name, .name & " ha cambiado la informaci�n sobre el BackUp")
        
            'Change the boolean to byte in a fast way
108         If doTheBackUp Then
110             MapInfo(.Pos.Map).backup_mode = 1
            
            Else
112             MapInfo(.Pos.Map).backup_mode = 0

            End If
        
            'Change the boolean to string in a fast way
114         Call WriteVar(MapPath & "mapa" & .Pos.Map & ".dat", "Mapa" & .Pos.Map, "backup", MapInfo(.Pos.Map).backup_mode)
        
116         Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & " Backup: " & MapInfo(.Pos.Map).backup_mode, e_FontTypeNames.FONTTYPE_INFO)

        End With
        
        Exit Sub

HandleChangeMapInfoBackup_Err:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChangeMapInfoBackup", Erl)
120
        
End Sub

''
' Handle the "ChangeMapInfoPK" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMapInfoPK(ByVal userindex As Integer)
        
        On Error GoTo HandleChangeMapInfoPK_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/24/06
        'Last modified by: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Change the pk`s info of the  map
        '***************************************************
100     With UserList(userindex)

            Dim isMapPk As Boolean
        
102         isMapPk = Reader.ReadBool()
        
104         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then
106             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
108         Call LogGM(.name, .name & " ha cambiado la informacion sobre si es seguro el mapa.")
        
110         MapInfo(.Pos.Map).Seguro = IIf(isMapPk, 1, 0)

112         Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & " Seguro: " & MapInfo(.Pos.Map).Seguro, e_FontTypeNames.FONTTYPE_INFO)

        End With
        
        Exit Sub

HandleChangeMapInfoPK_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChangeMapInfoPK", Erl)
116
        
End Sub

''
' Handle the "ChangeMapInfoRestricted" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMapInfoRestricted(ByVal userindex As Integer)

        '***************************************************
        'Author: Pablo (ToxicWaste)
        'Last Modification: 26/01/2007
        'Restringido -> Options: "NEWBIE", "SINMAGIA", "SININVI", "NOPKS", "NOCIUD".
        '***************************************************
        On Error GoTo ErrHandler

        Dim tStr As String
    
100     With UserList(userindex)

102         tStr = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) <> 0 Then

106             Select Case UCase$(tStr)
                
                    Case "NEWBIE"
108                     MapInfo(.Pos.Map).Newbie = Not MapInfo(.Pos.Map).Newbie
110                     Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & ": Newbie = " & MapInfo(.Pos.Map).Newbie, e_FontTypeNames.FONTTYPE_INFO)
112                     Call LogGM(.name, .name & " ha cambiado la restricci�n del mapa " & .Pos.Map & ": Newbie = " & MapInfo(.Pos.Map).Newbie)
                        
114                 Case "SINMAGIA"
116                     MapInfo(.Pos.Map).SinMagia = Not MapInfo(.Pos.Map).SinMagia
118                     Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & ": SinMagia = " & MapInfo(.Pos.Map).SinMagia, e_FontTypeNames.FONTTYPE_INFO)
120                     Call LogGM(.name, .name & " ha cambiado la restricci�n del mapa " & .Pos.Map & ": SinMagia = " & MapInfo(.Pos.Map).SinMagia)
                        
122                 Case "NOPKS"
124                     MapInfo(.Pos.Map).NoPKs = Not MapInfo(.Pos.Map).NoPKs
126                     Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & ": NoPKs = " & MapInfo(.Pos.Map).NoPKs, e_FontTypeNames.FONTTYPE_INFO)
128                     Call LogGM(.name, .name & " ha cambiado la restricci�n del mapa " & .Pos.Map & ": NoPKs = " & MapInfo(.Pos.Map).NoPKs)
                        
130                 Case "NOCIUD"
132                     MapInfo(.Pos.Map).NoCiudadanos = Not MapInfo(.Pos.Map).NoCiudadanos
134                     Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & ": NoCiudadanos = " & MapInfo(.Pos.Map).NoCiudadanos, e_FontTypeNames.FONTTYPE_INFO)
136                     Call LogGM(.name, .name & " ha cambiado la restricci�n del mapa " & .Pos.Map & ": NoCiudadanos = " & MapInfo(.Pos.Map).NoCiudadanos)
                        
138                 Case "SININVI"
140                     MapInfo(.Pos.Map).SinInviOcul = Not MapInfo(.Pos.Map).SinInviOcul
142                     Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & ": SinInvi = " & MapInfo(.Pos.Map).SinInviOcul, e_FontTypeNames.FONTTYPE_INFO)
144                     Call LogGM(.name, .name & " ha cambiado la restricci�n del mapa " & .Pos.Map & ": SinInvi = " & MapInfo(.Pos.Map).SinInviOcul)
                
146                 Case Else
148                     Call WriteConsoleMsg(userindex, "Opciones para restringir: 'NEWBIE', 'SINMAGIA', 'SININVI', 'NOPKS', 'NOCIUD'", e_FontTypeNames.FONTTYPE_INFO)

                End Select

            End If

        End With

        Exit Sub

ErrHandler:
150     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChangeMapInfoRestricted", Erl)
152

End Sub

''
' Handle the "ChangeMapInfoNoMagic" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMapInfoNoMagic(ByVal userindex As Integer)
        
        On Error GoTo HandleChangeMapInfoNoMagic_Err

        '***************************************************
        'Author: Pablo (ToxicWaste)
        'Last Modification: 26/01/2007
        'MagiaSinEfecto -> Options: "1" , "0".
        '***************************************************

        Dim nomagic As Boolean
    
100     With UserList(userindex)
  
102         nomagic = Reader.ReadBool
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             Call LogGM(.name, .name & " ha cambiado la informacion sobre si esta permitido usar la Magia el mapa.")
            End If

        End With
        
        Exit Sub

HandleChangeMapInfoNoMagic_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChangeMapInfoNoMagic", Erl)
110
        
End Sub

''
' Handle the "ChangeMapInfoNoInvi" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMapInfoNoInvi(ByVal userindex As Integer)
        
        On Error GoTo HandleChangeMapInfoNoInvi_Err

        '***************************************************
        'Author: Pablo (ToxicWaste)
        'Last Modification: 26/01/2007
        'InviSinEfecto -> Options: "1", "0"
        '***************************************************
        Dim noinvi As Boolean
    
100     With UserList(userindex)

102         noinvi = Reader.ReadBool()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             Call LogGM(.name, .name & " ha cambiado la informacion sobre si esta permitido usar Invisibilidad el mapa.")
            End If

        End With
        
        Exit Sub

HandleChangeMapInfoNoInvi_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChangeMapInfoNoInvi", Erl)
110
        
End Sub
            
''
' Handle the "ChangeMapInfoNoResu" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMapInfoNoResu(ByVal userindex As Integer)
        
        On Error GoTo HandleChangeMapInfoNoResu_Err

        Dim noresu As Boolean
    
100     With UserList(userindex)

102         noresu = Reader.ReadBool()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             Call LogGM(.name, .name & " ha cambiado la informacion sobre si esta permitido usar Resucitar el mapa.")
            End If

        End With
        
        Exit Sub

HandleChangeMapInfoNoResu_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChangeMapInfoNoResu", Erl)
110
        
End Sub

''
' Handle the "ChangeMapInfoLand" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMapInfoLand(ByVal userindex As Integer)

        '***************************************************
        'Author: Pablo (ToxicWaste)
        'Last Modification: 26/01/2007
        'Terreno -> Opciones: "BOSQUE", "NIEVE", "DESIERTO", "CIUDAD", "CAMPO", "DUNGEON".
        '***************************************************

        On Error GoTo ErrHandler

        Dim tStr As String
    
100     With UserList(userindex)

102         tStr = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
        
106             If tStr = "BOSQUE" Or tStr = "NIEVE" Or tStr = "DESIERTO" Or tStr = "CIUDAD" Or tStr = "CAMPO" Or tStr = "DUNGEON" Then
            
108                 Call LogGM(.name, .name & " ha cambiado la informacion del Terreno del mapa.")
                
110                 MapInfo(UserList(userindex).Pos.Map).terrain = tStr
                
112                 Call WriteVar(MapPath & "mapa" & UserList(userindex).Pos.Map & ".dat", "Mapa" & UserList(userindex).Pos.Map, "Terreno", tStr)
                
114                 Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & " Terreno: " & MapInfo(.Pos.Map).terrain, e_FontTypeNames.FONTTYPE_INFO)
                
                Else
            
116                 Call WriteConsoleMsg(userindex, "Opciones para terreno: 'BOSQUE', 'NIEVE', 'DESIERTO', 'CIUDAD', 'CAMPO', 'DUNGEON'", e_FontTypeNames.FONTTYPE_INFO)
118                 Call WriteConsoleMsg(userindex, "Igualmente, el �nico �til es 'NIEVE' ya que al ingresarlo, la gente muere de frio en el Mapa", e_FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End With

        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
122

End Sub

''
' Handle the "ChangeMapInfoZone" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMapInfoZone(ByVal userindex As Integer)

        '***************************************************
        'Author: Pablo (ToxicWaste)
        'Last Modification: 26/01/2007
        'Zona -> Opciones: "BOSQUE", "NIEVE", "DESIERTO", "CIUDAD", "CAMPO", "DUNGEON".
        '***************************************************
    
        On Error GoTo ErrHandler

        Dim tStr As String
    
100     With UserList(userindex)

102         tStr = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
        
106             If tStr = "BOSQUE" Or tStr = "NIEVE" Or tStr = "DESIERTO" Or tStr = "CIUDAD" Or tStr = "CAMPO" Or tStr = "DUNGEON" Then
            
108                 Call LogGM(.name, .name & " ha cambiado la informacion de la Zona del mapa.")
110                 MapInfo(UserList(userindex).Pos.Map).zone = tStr
112                 Call WriteVar(MapPath & "mapa" & UserList(userindex).Pos.Map & ".dat", "Mapa" & UserList(userindex).Pos.Map, "Zona", tStr)
114                 Call WriteConsoleMsg(userindex, "Mapa " & .Pos.Map & " Zona: " & MapInfo(.Pos.Map).zone, e_FontTypeNames.FONTTYPE_INFO)
                
                Else
            
116                 Call WriteConsoleMsg(userindex, "Opciones para terreno: 'BOSQUE', 'NIEVE', 'DESIERTO', 'CIUDAD', 'CAMPO', 'DUNGEON'", e_FontTypeNames.FONTTYPE_INFO)
118                 Call WriteConsoleMsg(userindex, "Igualmente, el �nico �til es 'DUNGEON' ya que al ingresarlo, NO se sentir� el efecto de la lluvia en este mapa.", e_FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End With

        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
122

End Sub


''
' Handle the "ShowGuildMessages" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleShowGuildMessages(ByVal userindex As Integer)

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/24/06
        'Last modified by: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Allows admins to read guild messages
        '***************************************************
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim guild As String
102             guild = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             Call modGuilds.GMEscuchaClan(userindex, guild)

            End If

        End With

        Exit Sub

ErrHandler:
108     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
110

End Sub

''
' Handle the "DoBackUp" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleDoBackUp(ByVal userindex As Integer)
        
        On Error GoTo HandleDoBackUp_Err

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/24/06
        'Show guilds messages
        '***************************************************
100     With UserList(userindex)
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub

104         Call LogGM(.name, .name & " ha hecho un backup")
        
106         Call ES.DoBackUp 'Sino lo confunde con la id del paquete

        End With
        
        Exit Sub

HandleDoBackUp_Err:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDoBackUp", Erl)
110
        
End Sub

''
' Handle the "AlterName" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleAlterName(ByVal userindex As Integer)

    '***************************************************
    'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
    'Last Modification: WyroX  -  11/07/2021
    'Change user name
    '***************************************************
    On Error GoTo ErrHandler

    With UserList(userindex)

        'Reads the userName and newUser Packets
        Dim UserName     As String
        Dim NewName      As String
        Dim TargetUI     As Integer
        Dim GuildIndex   As Integer

        UserName = UCase$(Reader.ReadString8())
        NewName = Reader.ReadString8()

        If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) = 0 Then Exit Sub

        If LenB(UserName) = 0 Or LenB(NewName) = 0 Then
            Call WriteConsoleMsg(userindex, "Usar: /ANAME origen@destino", e_FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        TargetUI = NameIndex(UserName)
        
        If TargetUI > 0 Then
            If UserList(TargetUI).GuildIndex > 0 Then
                Call WriteConsoleMsg(userindex, "El personaje " & UserName & " pertenece a un clan, debe salir del mismo con /salirclan para ser transferido.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        Else
            If Not PersonajeExiste(UserName) Then
                Call WriteConsoleMsg(userindex, "El personaje " & UserName & " es inexistente.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

            GuildIndex = GetUserGuildIndexDatabase(UserName)
            
            If GuildIndex > 0 Then
                Call WriteConsoleMsg(userindex, "El personaje " & UserName & " pertenece a un clan, debe salir del mismo con /salirclan para ser transferido.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        End If
        
        If PersonajeExiste(NewName) Then
            Call WriteConsoleMsg(userindex, "El nick solicitado ya existe.", e_FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        Call ChangeNameDatabase(UserName, NewName)

        Call WriteConsoleMsg(userindex, "Transferencia exitosa", e_FontTypeNames.FONTTYPE_INFO)

        Call SavePenaDatabase(UserName, .name & ": nombre cambiado de """ & UserName & """ a """ & NewName & """. " & Date & " " & Time)
        Call SendData(SendTarget.ToGM, 0, PrepareMessageConsoleMsg("Administraci�n � " & .name & " cambi� el nombre del usuario """ & UserName & """ por """ & NewName & """.", e_FontTypeNames.FONTTYPE_GM))
        Call LogGM(.name, "Ha cambiado de nombre al usuario """ & UserName & """. Ahora se llama """ & NewName & """.")
        
        If TargetUI > 0 Then
            UserList(TargetUI).name = NewName
            Call RefreshCharStatus(TargetUI)
        End If

    End With

    Exit Sub

ErrHandler:
150     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAlterName", Erl)
152

End Sub

''
' Handle the "HandleCreateNPC" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleCreateNPC(ByVal userindex As Integer)
        
        On Error GoTo HandleCreateNPC_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 12/24/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim NpcIndex As Integer
102         NpcIndex = Reader.ReadInt()

            If Not EsGM(userindex) Then Exit Sub
        
104         If .flags.Privilegios And (e_PlayerType.Consejero Or e_PlayerType.SemiDios) Then
106             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
        
112         NpcIndex = SpawnNpc(NpcIndex, .Pos, True, False)
        
114         If NpcIndex <> 0 Then
116             Call LogGM(.name, "Sumoneo a " & NpcList(NpcIndex).name & " en mapa " & .Pos.Map)

            End If

        End With
        
        Exit Sub

HandleCreateNPC_Err:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCreateNPC", Erl)
120
        
End Sub

''
' Handle the "CreateNPCWithRespawn" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleCreateNPCWithRespawn(ByVal userindex As Integer)
        
        On Error GoTo HandleCreateNPCWithRespawn_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 12/24/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim NpcIndex As Integer
        
102         NpcIndex = Reader.ReadInt()

            If Not EsGM(userindex) Then Exit Sub
        
104         If .flags.Privilegios And (e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.Dios) Then
106             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo. Si el motivo es probar algo ya saben ir a Test", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
108         NpcIndex = SpawnNpc(NpcIndex, .Pos, True, True)
        
110         If NpcIndex <> 0 Then
112             Call LogGM(.name, "Sumoneo con respawn " & NpcList(NpcIndex).name & " en mapa " & .Pos.Map)

            End If

        End With
        
        Exit Sub

HandleCreateNPCWithRespawn_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCreateNPCWithRespawn", Erl)
116
        
End Sub

''
' Handle the "ImperialArmour" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleImperialArmour(ByVal userindex As Integer)
        
        On Error GoTo HandleImperialArmour_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 12/24/06
        '
        '***************************************************

100     With UserList(userindex)
        
        
        
            Dim Index    As Byte
            Dim ObjIndex As Integer
        
102         Index = Reader.ReadInt()
104         ObjIndex = Reader.ReadInt()
        
106         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
108         Select Case Index

                Case 1
                    ' ArmaduraImperial1 = objindex
            
110             Case 2
                    ' ArmaduraImperial2 = objindex
            
112             Case 3
                    ' ArmaduraImperial3 = objindex
            
114             Case 4

                    ' TunicaMagoImperial = objindex
            End Select

        End With
        
        Exit Sub

HandleImperialArmour_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleImperialArmour", Erl)
118
        
End Sub

''
' Handle the "ChaosArmour" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChaosArmour(ByVal userindex As Integer)
        
        On Error GoTo HandleChaosArmour_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 12/24/06
        '
        '***************************************************

100     With UserList(userindex)

            Dim Index    As Byte
            Dim ObjIndex As Integer
        
102         Index = Reader.ReadInt()
104         ObjIndex = Reader.ReadInt()
        
106         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
108         Select Case Index

                Case 1
                    '   ArmaduraCaos1 = objindex
            
110             Case 2
                    '   ArmaduraCaos2 = objindex
            
112             Case 3
                    '   ArmaduraCaos3 = objindex
            
114             Case 4

                    '  TunicaMagoCaos = objindex
            End Select

        End With
        
        Exit Sub

HandleChaosArmour_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChaosArmour", Erl)
118
        
End Sub

''
' Handle the "NavigateToggle" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleNavigateToggle(ByVal userindex As Integer)
        
        On Error GoTo HandleNavigateToggle_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 01/12/07
        '
        '***************************************************
100     With UserList(userindex)
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
        
106         If .flags.Navegando = 1 Then
108             .flags.Navegando = 0
            
            Else
110             .flags.Navegando = 1

            End If
        
            'Tell the client that we are navigating.
112         Call WriteNavigateToggle(userindex)

        End With
        
        Exit Sub

HandleNavigateToggle_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleNavigateToggle", Erl)
116
        
End Sub

''
' Handle the "ServerOpenToUsersToggle" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleServerOpenToUsersToggle(ByVal userindex As Integer)
        
        On Error GoTo HandleServerOpenToUsersToggle_Err

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 12/24/06
        '
        '***************************************************
100     With UserList(userindex)
        
        
        
102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios Or e_PlayerType.RoleMaster)) Then Exit Sub
        
104         If ServerSoloGMs > 0 Then
106             Call WriteConsoleMsg(userindex, "Servidor habilitado para todos.", e_FontTypeNames.FONTTYPE_INFO)
108             ServerSoloGMs = 0
            
            Else
110             Call WriteConsoleMsg(userindex, "Servidor restringido a administradores.", e_FontTypeNames.FONTTYPE_INFO)
112             ServerSoloGMs = 1

            End If

        End With
        
        Exit Sub

HandleServerOpenToUsersToggle_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleServerOpenToUsersToggle", Erl)
116
        
End Sub

''
' Handle the "Participar" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleParticipar(ByVal userindex As Integer)
        On Error GoTo HandleParticipar_Err

        Dim handle As Integer
    
100     With UserList(userindex)

102         If Torneo.HayTorneoaActivo = False Then
104             Call WriteConsoleMsg(userindex, "No hay ning�n evento disponible.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
                   
106         If .flags.EnTorneo Then
108             Call WriteConsoleMsg(userindex, "Ya est�s participando.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
    
110         If .Stats.ELV > Torneo.nivelmaximo Then
112             Call WriteConsoleMsg(userindex, "El nivel m�ximo para participar es " & Torneo.nivelmaximo & ".", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
    
114         If .Stats.ELV < Torneo.NivelMinimo Then
116             Call WriteConsoleMsg(userindex, "El nivel m�nimo para participar es " & Torneo.NivelMinimo & ".", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
    
118         If .Stats.GLD < Torneo.costo Then
120             Call WriteConsoleMsg(userindex, "No tienes suficiente oro para ingresar.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
122         If .clase = Mage And Torneo.mago = 0 Then
124             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
126         If .clase = Cleric And Torneo.clerico = 0 Then
128             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
130         If .clase = Warrior And Torneo.guerrero = 0 Then
132             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
134         If .clase = Bard And Torneo.bardo = 0 Then
136             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
138         If .clase = Assasin And Torneo.asesino = 0 Then
140             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
   
142         If .clase = Druid And Torneo.druido = 0 Then
144             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
146         If .clase = Paladin And Torneo.Paladin = 0 Then
148             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
150         If .clase = Hunter And Torneo.cazador = 0 Then
152             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
154         If .clase = Trabajador And Torneo.Trabajador = 0 Then
156             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
158         If .clase = e_Class.Thief And Torneo.Ladron = 0 Then
160             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
   
162         If .clase = e_Class.Bandit And Torneo.Bandido = 0 Then
164             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
166         If .clase = e_Class.Pirat And Torneo.Pirata = 0 Then
168             Call WriteConsoleMsg(userindex, "Tu clase no participa de este evento.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
   
170         If Torneo.Participantes = Torneo.cupos Then
172             Call WriteConsoleMsg(userindex, "Los cupos ya estan llenos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
  
174         Call ParticiparTorneo(userindex)

        End With
        
        Exit Sub

HandleParticipar_Err:
176     Call TraceError(Err.Number, Err.Description, "Protocol.HandleParticipar", Erl)
178
        
End Sub

''
' Handle the "TurnCriminal" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleTurnCriminal(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 12/26/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             Call LogGM(.name, "/CONDEN " & UserName)
            
108             tUser = NameIndex(UserName)

110             If tUser > 0 Then Call VolverCriminal(tUser)

            End If

        End With

        Exit Sub

ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleTurnCriminal", Erl)
114

End Sub

''
' Handle the "ResetFactions" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleResetFactions(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 12/26/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)
 
            Dim UserName As String
            Dim tUser    As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             Call LogGM(.name, "/RAJAR " & UserName)
            
108             tUser = NameIndex(UserName)
            
110             If tUser > 0 Then Call ResetFacciones(tUser)

            End If

        End With

        Exit Sub

ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleResetFactions", Erl)
114

End Sub

''
' Handle the "RemoveCharFromGuild" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleRemoveCharFromGuild(ByVal userindex As Integer)

        '***************************************************
        'Author: Juan Mart�n Sotuyo Dodero (Maraxus)
        'Last Modification: 12/26/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)
 
            Dim UserName   As String
            Dim GuildIndex As Integer
        
102         UserName = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             Call LogGM(.name, "/RAJARCLAN " & UserName)
            
108             GuildIndex = modGuilds.m_EcharMiembroDeClan(userindex, UserName)
            
110             If GuildIndex = 0 Then
112                 Call WriteConsoleMsg(userindex, "No pertenece a ning�n clan o es fundador.", e_FontTypeNames.FONTTYPE_INFO)
                Else
114                 Call WriteConsoleMsg(userindex, "Expulsado.", e_FontTypeNames.FONTTYPE_INFO)
116                 Call SendData(SendTarget.ToGuildMembers, GuildIndex, PrepareMessageConsoleMsg(UserName & " ha sido expulsado del clan por los administradores del servidor.", e_FontTypeNames.FONTTYPE_GUILD))

                End If

            End If

        End With

        Exit Sub

ErrHandler:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRemoveCharFromGuild", Erl)
120

End Sub

''
' Handle the "SystemMessage" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleSystemMessage(ByVal userindex As Integer)

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 12/29/06
        'Send a message to all the users
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Message As String
102             Message = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
106             Call LogGM(.name, "Mensaje de sistema:" & Message)
            
108             Call SendData(SendTarget.ToAll, 0, PrepareMessageShowMessageBox(Message))

            End If

        End With

        Exit Sub

ErrHandler:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSystemMessage", Erl)
112

End Sub

''
' Handle the "SetMOTD" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleSetMOTD(ByVal userindex As Integer)

        '***************************************************
        'Author: Lucas Tavolaro Ortiz (Tavo)
        'Last Modification: 03/31/07
        'Set the MOTD
        'Modified by: Juan Mart�n Sotuyo Dodero (Maraxus)
        '   - Fixed a bug that prevented from properly setting the new number of lines.
        '   - Fixed a bug that caused the player to be kicked.
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim newMOTD           As String

            Dim auxiliaryString() As String

            Dim LoopC             As Long
        
102         newMOTD = Reader.ReadString8()
104         auxiliaryString = Split(newMOTD, vbCrLf)
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.RoleMaster)) Then
108             Call LogGM(.name, "Ha fijado un nuevo MOTD")
            
110             MaxLines = UBound(auxiliaryString()) + 1
                If MaxLines > 0 Then
112             ReDim MOTD(1 To MaxLines)
            
114                 Call WriteVar(DatPath & "Motd.ini", "INIT", "NumLines", CStr(MaxLines))
                
116                 For LoopC = 1 To MaxLines
118                     Call WriteVar(DatPath & "Motd.ini", "Motd", "Line" & CStr(LoopC), auxiliaryString(LoopC - 1))
                    
120                     MOTD(LoopC).texto = auxiliaryString(LoopC - 1)
122                 Next LoopC
                
124                 Call WriteConsoleMsg(userindex, "Se ha cambiado el MOTD con exito", e_FontTypeNames.FONTTYPE_INFO)
                Else
                    ReDim MOTD(0 To 0)
                End If
            End If

        End With

        Exit Sub

ErrHandler:
126     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSetMOTD", Erl)
128

End Sub

''
' Handle the "ChangeMOTD" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandleChangeMOTD(ByVal userindex As Integer)
        
        On Error GoTo HandleChangeMOTD_Err

        '***************************************************
        'Author: Juan Mart�n sotuyo Dodero (Maraxus)
        'Last Modification: 12/29/06
        'Change the MOTD
        '***************************************************
100     With UserList(userindex)
  
102         If (.flags.Privilegios And (e_PlayerType.RoleMaster Or e_PlayerType.user Or e_PlayerType.Consejero Or e_PlayerType.SemiDios)) Then Exit Sub

            Dim auxiliaryString As String

            Dim LoopC           As Long
            
104         For LoopC = LBound(MOTD()) To UBound(MOTD())
106             auxiliaryString = auxiliaryString & MOTD(LoopC).texto & vbCrLf
108         Next LoopC
        
110         If Len(auxiliaryString) >= 2 Then
        
112             If Right$(auxiliaryString, 2) = vbCrLf Then
114                 auxiliaryString = Left$(auxiliaryString, Len(auxiliaryString) - 2)
                End If

            End If
        
116         Call WriteShowMOTDEditionForm(userindex, auxiliaryString)

        End With
        
        Exit Sub

HandleChangeMOTD_Err:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleChangeMOTD", Erl)
120
        
End Sub

''
' Handle the "Ping" message
'
' @param UserIndex The index of the user sending the message

Public Sub HandlePing(ByVal userindex As Integer)
        
        On Error GoTo HandlePing_Err

            Dim Time As Long
        
102         Time = Reader.ReadInt()
        
104         Call WritePong(userindex, Time + modNetwork.GetTimeOfNextFlush()) ' Correct the time
        Exit Sub

HandlePing_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePing", Erl)
108
        
End Sub

Private Sub HandleQuestionGM(ByVal userindex As Integer)

        Dim TActual     As Long
        Dim ElapsedTime As Long
        
96      TActual = GetTickCount()
98      ElapsedTime = TActual - UserList(userindex).Counters.LastGmMessage
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Consulta       As String
            Dim TipoDeConsulta As String

102         Consulta = Reader.ReadString8()
104         TipoDeConsulta = Reader.ReadString8()

            Dim PacketCounter As Long
            PacketCounter = Reader.ReadInt
                        
            Dim Packet_ID As Long
            Packet_ID = PacketNames.QuestionGM
            
            If Not verifyTimeStamp(PacketCounter, .PacketCounters(Packet_ID), .PacketTimers(Packet_ID), .MacroIterations(Packet_ID), userindex, "QuestionGM", PacketTimerThreshold(Packet_ID), MacroIterations(Packet_ID)) Then Exit Sub

            .Counters.CounterGmMessages = .Counters.CounterGmMessages + 1
            
            If .Counters.CounterGmMessages >= 20 Then
                Dim bannedip As String
                bannedip = UserList(userindex).IP
132             Call BanearIP(0, UserList(userindex).name, bannedip, UserList(userindex).Cuenta)
134             Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Se bane� la IP  " & bannedip & " del personaje " & UserList(userindex).name & " por bot.", e_FontTypeNames.FONTTYPE_FIGHT))
                
                'Find every player with that ip and ban him!
                Dim i As Long
136             For i = 1 To LastUser
138                 If UserList(i).ConnIDValida Then
140                     If UserList(i).IP = bannedip Then
142                         Call WriteCerrarleCliente(i)
144                         Call CloseSocket(i)
                        End If
                    End If
146             Next i
            End If
            
            If ElapsedTime < IntervaloConsultaGM Then
115             Call WriteConsoleMsg(userindex, "Solo puedes enviar una consulta cada 5 minutos.", e_FontTypeNames.FONTTYPE_WARNING)
                Exit Sub
            End If
            UserList(userindex).Counters.LastGmMessage = TActual
112         Call Ayuda.Push(.name, Consulta, TipoDeConsulta)
114         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Se ha recibido un nuevo mensaje de soporte de " & UserList(userindex).name & ".", e_FontTypeNames.FONTTYPE_SERVER))
            .Counters.CounterGmMessages = 0
116         Call WriteConsoleMsg(userindex, "Tu mensaje fue recibido por el equipo de soporte.", e_FontTypeNames.FONTTYPE_INFOIAO)
        
118         Call LogConsulta(.name & " (" & TipoDeConsulta & ") " & Consulta)

        End With
    
        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
122

End Sub

Private Sub HandleOfertaInicial(ByVal userindex As Integer)
        
        On Error GoTo HandleOfertaInicial_Err
    
100     With UserList(userindex)

            Dim Oferta As Long
102             Oferta = Reader.ReadInt()
        
104         If UserList(userindex).flags.Muerto = 1 Then
106             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                
                Exit Sub

            End If

108         If .flags.TargetNPC < 1 Then
110             Call WriteConsoleMsg(userindex, "Primero ten�s que hacer click sobre el subastador.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

112         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Subastador Then
114             Call WriteConsoleMsg(userindex, "Primero ten�s que hacer click sobre el subastador.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
116         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 2 Then
118             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos del subastador.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
120         If .flags.Subastando = False Then
122             Call WriteChatOverHead(userindex, "Oye amigo, tu no pod�s decirme cual es la oferta inicial.", NpcList(UserList(userindex).flags.TargetNPC).Char.CharIndex, vbWhite)
                Exit Sub

            End If
        
124         If Subasta.HaySubastaActiva = False And .flags.Subastando = False Then
126             Call WriteConsoleMsg(userindex, "No hay ninguna subasta en curso.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
128         If .flags.Subastando = True Then
130             UserList(userindex).Counters.TiempoParaSubastar = 0
132             Subasta.OfertaInicial = Oferta
134             Subasta.MejorOferta = 0
136             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.name & " est� subastando: " & ObjData(Subasta.ObjSubastado).name & " (Cantidad: " & Subasta.ObjSubastadoCantidad & " ) - con un precio inicial de " & PonerPuntos(Subasta.OfertaInicial) & " monedas. Escribe /OFERTAR (cantidad) para participar.", e_FontTypeNames.FONTTYPE_SUBASTA))
138             .flags.Subastando = False
140             Subasta.HaySubastaActiva = True
142             Subasta.Subastador = .name
144             Subasta.MinutosDeSubasta = 5
146             Subasta.TiempoRestanteSubasta = 300
148             Call LogearEventoDeSubasta("#################################################################################################################################################################################################")
150             Call LogearEventoDeSubasta("El dia: " & Date & " a las " & Time)
152             Call LogearEventoDeSubasta(.name & ": Esta subastando el item numero " & Subasta.ObjSubastado & " con una cantidad de " & Subasta.ObjSubastadoCantidad & " y con un precio inicial de " & PonerPuntos(Subasta.OfertaInicial) & " monedas.")
154             frmMain.SubastaTimer.Enabled = True
156             Call WarpUserChar(userindex, 14, 27, 64, True)

                'lalala toda la bola de los timerrr
            End If

        End With
        
        Exit Sub

HandleOfertaInicial_Err:
158     Call TraceError(Err.Number, Err.Description, "Protocol.HandleOfertaInicial", Erl)
160
        
End Sub

Private Sub HandleOfertaDeSubasta(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Oferta   As Long
            Dim ExOferta As Long
        
102         Oferta = Reader.ReadInt()
        
104         If Subasta.HaySubastaActiva = False Then
106             Call WriteConsoleMsg(userindex, "No hay ninguna subasta en curso.", e_FontTypeNames.FONTTYPE_INFOIAO)
            
                Exit Sub

            End If
               
108         If Oferta < Subasta.MejorOferta + 100 Then
110             Call WriteConsoleMsg(userindex, "Debe haber almenos una diferencia de 100 monedas a la ultima oferta!", e_FontTypeNames.FONTTYPE_INFOIAO)
            
                Exit Sub

            End If
        
112         If .name = Subasta.Subastador Then
114             Call WriteConsoleMsg(userindex, "No pod�s auto ofertar en tus subastas. La proxima vez iras a la carcel...", e_FontTypeNames.FONTTYPE_INFOIAO)
            
                Exit Sub

            End If
        
116         If .Stats.GLD >= Oferta Then

                'revisar que pasa si el usuario que oferto antes esta offline
                'Devolvemos el oro al usuario que oferto antes...(si es que hubo oferta)
118             If Subasta.HuboOferta = True Then
120                 ExOferta = NameIndex(Subasta.Comprador)
122                 UserList(ExOferta).Stats.GLD = UserList(ExOferta).Stats.GLD + Subasta.MejorOferta
124                 Call WriteUpdateGold(ExOferta)

                End If
            
126             Subasta.MejorOferta = Oferta
128             Subasta.Comprador = .name
            
130             .Stats.GLD = .Stats.GLD - Oferta
132             Call WriteUpdateGold(userindex)
            
134             If Subasta.TiempoRestanteSubasta < 60 Then
136                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Oferta mejorada por: " & .name & " (Ofrece " & PonerPuntos(Oferta) & " monedas de oro) - Tiempo Extendido. Escribe /SUBASTA para mas informaci�n.", e_FontTypeNames.FONTTYPE_SUBASTA))
138                 Call LogearEventoDeSubasta(.name & ": Mejoro la oferta en el ultimo minuto ofreciendo " & PonerPuntos(Oferta) & " monedas.")
140                 Subasta.TiempoRestanteSubasta = Subasta.TiempoRestanteSubasta + 30
                Else
142                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Oferta mejorada por: " & .name & " (Ofrece " & PonerPuntos(Oferta) & " monedas de oro). Escribe /SUBASTA para mas informaci�n.", e_FontTypeNames.FONTTYPE_SUBASTA))
144                 Call LogearEventoDeSubasta(.name & ": Mejoro la oferta ofreciendo " & PonerPuntos(Oferta) & " monedas.")
146                 Subasta.HuboOferta = True
148                 Subasta.PosibleCancelo = False

                End If

            Else
150             Call WriteConsoleMsg(userindex, "No posees esa cantidad de oro.", e_FontTypeNames.FONTTYPE_INFOIAO)

            End If

        End With
    
        Exit Sub

ErrHandler:
152     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
154

End Sub

Private Sub HandleSetSpeed(ByVal userindex As Integer)
        
        Dim Speed As Single
        
        On Error GoTo HandleGlobalOnOff_Err
        
        Speed = Reader.ReadReal32()
        
        'Author: Pablo Mercavides
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) = 0 Then Exit Sub
            
            UserList(userindex).Char.speeding = Speed
            
            Call WriteVelocidadToggle(Speed)
        
        End With
        
        Exit Sub

HandleGlobalOnOff_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGlobalOnOff", Erl)
118
        
End Sub

Private Sub HandleGlobalMessage(ByVal userindex As Integer)
        
        Dim TActual     As Long
        Dim ElapsedTime As Long

100     TActual = GetTickCount()
102     ElapsedTime = TActual - UserList(userindex).Counters.MensajeGlobal
                
        On Error GoTo ErrHandler

104     With UserList(userindex)

            Dim chat As String

106         chat = Reader.ReadString8()

108         If .flags.Silenciado = 1 Then
110             Call WriteLocaleMsg(userindex, "110", e_FontTypeNames.FONTTYPE_VENENO, .flags.MinutosRestantes)
112         ElseIf ElapsedTime < IntervaloMensajeGlobal Then
114             Call WriteConsoleMsg(userindex, "No puedes escribir mensajes globales tan r�pido.", e_FontTypeNames.FONTTYPE_WARNING)
        
            Else
116             UserList(userindex).Counters.MensajeGlobal = TActual

118             If EstadoGlobal Then
120                 If LenB(chat) <> 0 Then
                        ' WyroX: Foto-denuncias - Push message
                        Dim i As Integer

124                     For i = 1 To UBound(.flags.ChatHistory) - 1
126                         .flags.ChatHistory(i) = .flags.ChatHistory(i + 1)
                        Next
128                     .flags.ChatHistory(UBound(.flags.ChatHistory)) = chat

130                     Call modSendData.SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("[" & .name & "] " & chat, e_FontTypeNames.FONTTYPE_GLOBAL))

                        'TODO : Con la 0.12.1 se debe definir si esto vuelve o se borra (/CMSG overhead)
                        'Call SendData(SendTarget.ToPCArea, UserIndex, UserList(UserIndex).Pos.map, "||" & vbBlue & "�< " & rData & " >�" & CStr(UserList(UserIndex).Char.CharIndex))
                    End If

                Else
132                 Call WriteConsoleMsg(userindex, "El global se encuentra Desactivado.", e_FontTypeNames.FONTTYPE_GLOBAL)

                End If

            End If
    
        End With
    
        Exit Sub

ErrHandler:
134     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
136

End Sub

Public Sub HandleGlobalOnOff(ByVal userindex As Integer)
        
        On Error GoTo HandleGlobalOnOff_Err

        'Author: Pablo Mercavides
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) = 0 Then Exit Sub
        
104         Call LogGM(.name, " activo al Chat Global a las " & Now)
        
106         If EstadoGlobal = False Then
108             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor � Chat general habilitado. Escribe" & Chr(34) & "/CONSOLA" & Chr(34) & " o " & Chr(34) & ";" & Chr(34) & " y su mensaje para utilizarlo.", e_FontTypeNames.FONTTYPE_SERVER))
110             EstadoGlobal = True
            Else
112             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor � Chat General deshabilitado.", e_FontTypeNames.FONTTYPE_SERVER))
114             EstadoGlobal = False

            End If
        
        End With
        
        Exit Sub

HandleGlobalOnOff_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGlobalOnOff", Erl)
118
        
End Sub


Private Sub HandleCuentaRegresiva(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)
 
            Dim Seconds As Byte
        
102         Seconds = Reader.ReadInt()

104         If Not .flags.Privilegios And e_PlayerType.user Then
106             CuentaRegresivaTimer = Seconds
108             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("�Empezando cuenta regresiva desde: " & Seconds & " segundos...!", e_FontTypeNames.FONTTYPE_GUILD))
        
            
            End If

        End With
    
        Exit Sub

ErrHandler:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCuentaRegresiva", Erl)
112

End Sub

Private Sub HandlePossUser(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)
 
            Dim UserName As String
        
102         UserName = Reader.ReadString8()

            If Not InStrB(UserName, "(") Then Exit Sub
            'HarThaoS: Modifico la forma en que se usa el destrabar, ahora solamente lo puedo destrabar si est� online.
104         If (.flags.Privilegios And (e_PlayerType.user)) = 0 Then
                Dim tempIndex As Integer
                UserName = Split(UserName, "(")(0)
                tempIndex = NameIndex(UserName)
106             If tempIndex > 0 Then
                    If LegalPosDestrabar(UserList(tempIndex).Pos.Map, UserList(tempIndex).Pos.X, UserList(tempIndex).Pos.Y, .flags.Navegando = 1, .flags.Navegando = 0) Then Exit Sub
                    
                    Dim nPos As t_WorldPos
                                        
                    Call ClosestLegalPos(UserList(tempIndex).Pos, nPos, False, True)
                    
150                 Call FindLegalPos(tempIndex, UserList(tempIndex).Pos.Map, CByte(UserList(tempIndex).Pos.X), CByte(UserList(tempIndex).Pos.Y))
152                 Call WarpUserChar(tempIndex, nPos.Map, nPos.X, nPos.Y, True)
                    
116                 Call WriteConsoleMsg(userindex, "Servidor � Acci�n realizada con exito! La nueva posicion de " & UserName & " es: " & UserList(tempIndex).Pos.Map & "-" & UserList(tempIndex).Pos.X & "-" & UserList(tempIndex).Pos.Y & ".", e_FontTypeNames.FONTTYPE_INFO)
                    'HarTaoS ReyarB ver porque si el usuario esta online lo dice igual
                Else
118                 Call WriteConsoleMsg(userindex, "Servidor � El usuario debe estar deslogueado para dicha solicitud!", e_FontTypeNames.FONTTYPE_INFO)
                    'HarTaoS ReyarB avisar al usuario que un gm lo destrabara pero debe desloguear
                End If
            Else
120             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If
        End With
    
        Exit Sub

ErrHandler:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePossUser", Erl)
124

End Sub

Private Sub HandleDuel(ByVal userindex As Integer)
    
        On Error GoTo ErrHandler
        
        Dim Players         As String
        Dim Bet             As Long
        Dim PocionesMaximas As Integer
        Dim CaenItems       As Boolean

100     With UserList(userindex)

102         Players = Reader.ReadString8
104         Bet = Reader.ReadInt
106         PocionesMaximas = Reader.ReadInt
108         CaenItems = Reader.ReadBool
            Call WriteConsoleMsg(userindex, "No puedes realizar un reto en este momento.", e_FontTypeNames.FONTTYPE_INFO)
            Exit Sub
110         Call CrearReto(userindex, Players, Bet, PocionesMaximas, CaenItems)

        End With
    
        Exit Sub
    
ErrHandler:

112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDuel", Erl)
114

End Sub

Private Sub HandleAcceptDuel(ByVal userindex As Integer)

        On Error GoTo ErrHandler
        
        Dim Offerer As String

100     With UserList(userindex)

102         Offerer = Reader.ReadString8

104         Call AceptarReto(userindex, Offerer)

        End With
    
        Exit Sub
    
ErrHandler:

106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAcceptDuel", Erl)
108

End Sub

Private Sub HandleCancelDuel(ByVal userindex As Integer)

100     With UserList(userindex)

102         Reader.ReadInt

104         If .flags.SolicitudReto.estado <> e_SolicitudRetoEstado.Libre Then
106             Call CancelarSolicitudReto(userindex, .name & " ha cancelado la solicitud.")

108         ElseIf .flags.AceptoReto > 0 Then
110             Call CancelarSolicitudReto(.flags.AceptoReto, .name & " ha cancelado su admisi�n.")

            End If

        End With

End Sub

Private Sub HandleQuitDuel(ByVal userindex As Integer)

100     With UserList(userindex)

102         If .flags.EnReto Then
104             Call AbandonarReto(userindex)
            End If

        End With

End Sub

Private Sub HandleNieveToggle(ByVal userindex As Integer)
        
        On Error GoTo HandleNieveToggle_Err

        'Author: Pablo Mercavides
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
106         Call LogGM(.name, "/NIEVE")
        
108         Nebando = Not Nebando
        
110         Call SendData(SendTarget.ToAll, 0, PrepareMessageNevarToggle())

        End With
        
        Exit Sub

HandleNieveToggle_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleNieveToggle", Erl)
114
        
End Sub

Private Sub HandleNieblaToggle(ByVal userindex As Integer)
        
        On Error GoTo HandleNieblaToggle_Err

        'Author: Pablo Mercavides
100     With UserList(userindex)

102         If (.flags.Privilegios And (e_PlayerType.user Or e_PlayerType.Consejero)) Then
104             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
        
106         Call LogGM(.name, "/NIEBLA")
108         Call ResetMeteo

        End With
        
        Exit Sub

HandleNieblaToggle_Err:
110     Call TraceError(Err.Number, Err.Description, "Protocol.HandleNieblaToggle", Erl)
112
        
End Sub

Private Sub HandleTransFerGold(ByVal userindex As Integer)
        'Author: Pablo Mercavides

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim Cantidad As Long
            Dim tUser    As Integer
        
102         Cantidad = Reader.ReadInt()
104         UserName = Reader.ReadString8()

            ' WyroX: Chequeos de seguridad... Estos chequeos ya se hacen en el cliente, pero si no se hacen se puede duplicar oro...

            ' Cantidad v�lida?
106         If Cantidad <= 0 Then Exit Sub

            ' Tiene el oro?
108         If .Stats.Banco < Cantidad Then Exit Sub
            
110         If .flags.Muerto = 1 Then
112             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'Validate target NPC
114         If .flags.TargetNPC = 0 Then
116             Call WriteConsoleMsg(userindex, "Primero ten�s que seleccionar un personaje, haz click izquierdo sobre �l.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

118         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Banquero Then Exit Sub
            
120         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 10 Then
122             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

124         tUser = NameIndex(UserName)

            ' Enviar a vos mismo?
126         If tUser = userindex Then
128             Call WriteChatOverHead(userindex, "�No puedo enviarte oro a vos mismo!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                Exit Sub

            End If
    
130         If Not EsGM(userindex) Then

132             If tUser <= 0 Then
                        If GetTickCount() - .Counters.LastTransferGold >= 10000 Then
                            If PersonajeExiste(UserName) Then
136                             If Not AddOroBancoDatabase(UserName, Cantidad) Then
138                                 Call WriteChatOverHead(userindex, "Error al realizar la operaci�n.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                                    Exit Sub
                                End If
                                .Counters.LastTransferGold = GetTickCount()
                            Else
                                Call WriteChatOverHead(userindex, "El usuario no existe.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                                Exit Sub
                            End If
                        Else
                            Call WriteChatOverHead(userindex, "Espera un momento.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
                            Exit Sub
                        End If


                Else
148                 UserList(tUser).Stats.Banco = UserList(tUser).Stats.Banco + val(Cantidad) 'Se lo damos al otro.

                End If
                
150             UserList(userindex).Stats.Banco = UserList(userindex).Stats.Banco - val(Cantidad) 'Quitamos el oro al usuario
    
152             Call WriteChatOverHead(userindex, "�El env�o se ha realizado con �xito! Gracias por utilizar los servicios de Finanzas Goliath", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
'154             Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave("173", UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y))
        
            Else
156             Call WriteChatOverHead(userindex, "Los administradores no pueden transferir oro.", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
158             Call LogGM(.name, "Quizo transferirle oro a: " & UserName)
            
            End If

        End With
    
        Exit Sub

ErrHandler:
160     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
162

End Sub

Private Sub HandleMoveItem(ByVal userindex As Integer)
        'Author: Pablo Mercavides

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim SlotViejo As Byte
            Dim SlotNuevo As Byte
        
102         SlotViejo = Reader.ReadInt()
104         SlotNuevo = Reader.ReadInt()
        
            Dim Objeto    As t_Obj
            Dim Equipado  As Boolean
            Dim Equipado2 As Boolean
            Dim Equipado3 As Boolean
            Dim ObjCania As t_Obj
            'HarThaoS: Si es un hilo de pesca y lo estoy arrastrando en una ca�a rota borro del slot viejo y en el nuevo pongo la ca�a correspondiente
             If SlotViejo > getMaxInventorySlots(userindex) Or SlotNuevo > getMaxInventorySlots(userindex) Or SlotViejo <= 0 Or SlotNuevo <= 0 Then Exit Sub
            
            If .Invent.Object(SlotViejo).ObjIndex = 2183 Then
            
                Select Case .Invent.Object(SlotNuevo).ObjIndex
                     Case 3457
                        ObjCania.ObjIndex = 881
                    Case 3456
                        ObjCania.ObjIndex = 2121
                    Case 3459
                        ObjCania.ObjIndex = 2132
                    Case 3458
                        ObjCania.ObjIndex = 2133
                End Select
                ObjCania.amount = 1
                'si el objeto que estaba pisando era una ca�a rota.
                If ObjCania.ObjIndex > 0 Then
                    'Quitamos del inv el item
                    Call QuitarUserInvItem(userindex, SlotViejo, 1)
                    Call UpdateUserInv(False, userindex, SlotViejo)
                    Call QuitarUserInvItem(userindex, SlotNuevo, 1)
                    Call UpdateUserInv(False, userindex, SlotNuevo)
                    Call MeterItemEnInventario(userindex, ObjCania)
                    Exit Sub
                End If
                
            End If
            
        
106         If (SlotViejo > .CurrentInventorySlots) Or (SlotNuevo > .CurrentInventorySlots) Then
108             Call WriteConsoleMsg(userindex, "Espacio no desbloqueado.", e_FontTypeNames.FONTTYPE_INFOIAO)
            
            Else
    
110             If .Invent.Object(SlotNuevo).ObjIndex = .Invent.Object(SlotViejo).ObjIndex Then
112                 .Invent.Object(SlotNuevo).amount = .Invent.Object(SlotNuevo).amount + .Invent.Object(SlotViejo).amount
                    
                    Dim Excedente As Integer
114                 Excedente = .Invent.Object(SlotNuevo).amount - MAX_INVENTORY_OBJS

116                 If Excedente > 0 Then
118                     .Invent.Object(SlotViejo).amount = Excedente
120                     .Invent.Object(SlotNuevo).amount = MAX_INVENTORY_OBJS
                    Else

122                     If .Invent.Object(SlotViejo).Equipped = 1 Then
124                         .Invent.Object(SlotNuevo).Equipped = 1

                        End If
                    
126                     .Invent.Object(SlotViejo).ObjIndex = 0
128                     .Invent.Object(SlotViejo).amount = 0
130                     .Invent.Object(SlotViejo).Equipped = 0
                    
                        'Cambiamos si alguno es un anillo
132                     If .Invent.Da�oMagicoEqpSlot = SlotViejo Then
134                         .Invent.Da�oMagicoEqpSlot = SlotNuevo

                        End If

136                     If .Invent.ResistenciaEqpSlot = SlotViejo Then
138                         .Invent.ResistenciaEqpSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es un armor
140                     If .Invent.ArmourEqpSlot = SlotViejo Then
142                         .Invent.ArmourEqpSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es un barco
144                     If .Invent.BarcoSlot = SlotViejo Then
146                         .Invent.BarcoSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es una montura
148                     If .Invent.MonturaSlot = SlotViejo Then
150                         .Invent.MonturaSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es un casco
152                     If .Invent.CascoEqpSlot = SlotViejo Then
154                         .Invent.CascoEqpSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es un escudo
156                     If .Invent.EscudoEqpSlot = SlotViejo Then
158                         .Invent.EscudoEqpSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es munici�n
160                     If .Invent.MunicionEqpSlot = SlotViejo Then
162                         .Invent.MunicionEqpSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es un arma
164                     If .Invent.WeaponEqpSlot = SlotViejo Then
166                         .Invent.WeaponEqpSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es un nudillo
168                     If .Invent.NudilloSlot = SlotViejo Then
170                         .Invent.NudilloSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es un magico
172                     If .Invent.MagicoSlot = SlotViejo Then
174                         .Invent.MagicoSlot = SlotNuevo

                        End If
                        
                        'Cambiamos si alguno es una herramienta
176                     If .Invent.HerramientaEqpSlot = SlotViejo Then
178                         .Invent.HerramientaEqpSlot = SlotNuevo

                        End If

                    End If
                
                Else

180                 If .Invent.Object(SlotNuevo).ObjIndex <> 0 Then
182                     Objeto.amount = .Invent.Object(SlotViejo).amount
184                     Objeto.ObjIndex = .Invent.Object(SlotViejo).ObjIndex
                    
186                     If .Invent.Object(SlotViejo).Equipped = 1 Then
188                         Equipado = True
    
                        End If
                    
190                     If .Invent.Object(SlotNuevo).Equipped = 1 Then
192                         Equipado2 = True
    
                        End If
                    
                        '  If .Invent.Object(SlotNuevo).Equipped = 1 And .Invent.Object(SlotViejo).Equipped = 1 Then
                        '     Equipado3 = True
                        ' End If
                    
194                     .Invent.Object(SlotViejo).ObjIndex = .Invent.Object(SlotNuevo).ObjIndex
196                     .Invent.Object(SlotViejo).amount = .Invent.Object(SlotNuevo).amount
                    
198                     .Invent.Object(SlotNuevo).ObjIndex = Objeto.ObjIndex
200                     .Invent.Object(SlotNuevo).amount = Objeto.amount
                    
202                     If Equipado Then
204                         .Invent.Object(SlotNuevo).Equipped = 1
                        Else
206                         .Invent.Object(SlotNuevo).Equipped = 0
    
                        End If
                                    
208                     If Equipado2 Then
210                         .Invent.Object(SlotViejo).Equipped = 1
                        Else
212                         .Invent.Object(SlotViejo).Equipped = 0
    
                        End If
    
                    End If
    
                    'Cambiamos si alguno es un anillo
214                 If .Invent.Da�oMagicoEqpSlot = SlotViejo Then
216                     .Invent.Da�oMagicoEqpSlot = SlotNuevo
218                 ElseIf .Invent.Da�oMagicoEqpSlot = SlotNuevo Then
220                     .Invent.Da�oMagicoEqpSlot = SlotViejo

                    End If

222                 If .Invent.ResistenciaEqpSlot = SlotViejo Then
224                     .Invent.ResistenciaEqpSlot = SlotNuevo
226                 ElseIf .Invent.ResistenciaEqpSlot = SlotNuevo Then
228                     .Invent.ResistenciaEqpSlot = SlotViejo

                    End If
                    
                    'Cambiamos si alguno es un armor
230                 If .Invent.ArmourEqpSlot = SlotViejo Then
232                     .Invent.ArmourEqpSlot = SlotNuevo
234                 ElseIf .Invent.ArmourEqpSlot = SlotNuevo Then
236                     .Invent.ArmourEqpSlot = SlotViejo
    
                    End If
                    
                    'Cambiamos si alguno es un barco
238                 If .Invent.BarcoSlot = SlotViejo Then
240                     .Invent.BarcoSlot = SlotNuevo
242                 ElseIf .Invent.BarcoSlot = SlotNuevo Then
244                     .Invent.BarcoSlot = SlotViejo
    
                    End If
                     
                    'Cambiamos si alguno es una montura
246                 If .Invent.MonturaSlot = SlotViejo Then
248                     .Invent.MonturaSlot = SlotNuevo
250                 ElseIf .Invent.MonturaSlot = SlotNuevo Then
252                     .Invent.MonturaSlot = SlotViejo
    
                    End If
                    
                    'Cambiamos si alguno es un casco
254                 If .Invent.CascoEqpSlot = SlotViejo Then
256                     .Invent.CascoEqpSlot = SlotNuevo
258                 ElseIf .Invent.CascoEqpSlot = SlotNuevo Then
260                     .Invent.CascoEqpSlot = SlotViejo
    
                    End If
                    
                    'Cambiamos si alguno es un escudo
262                 If .Invent.EscudoEqpSlot = SlotViejo Then
264                     .Invent.EscudoEqpSlot = SlotNuevo
266                 ElseIf .Invent.EscudoEqpSlot = SlotNuevo Then
268                     .Invent.EscudoEqpSlot = SlotViejo
    
                    End If
                    
                    'Cambiamos si alguno es munici�n
270                 If .Invent.MunicionEqpSlot = SlotViejo Then
272                     .Invent.MunicionEqpSlot = SlotNuevo
274                 ElseIf .Invent.MunicionEqpSlot = SlotNuevo Then
276                     .Invent.MunicionEqpSlot = SlotViejo
    
                    End If
                    
                    'Cambiamos si alguno es un arma
278                 If .Invent.WeaponEqpSlot = SlotViejo Then
280                     .Invent.WeaponEqpSlot = SlotNuevo
282                 ElseIf .Invent.WeaponEqpSlot = SlotNuevo Then
284                     .Invent.WeaponEqpSlot = SlotViejo
    
                    End If
                     
                    'Cambiamos si alguno es un nudillo
286                 If .Invent.NudilloSlot = SlotViejo Then
288                     .Invent.NudilloSlot = SlotNuevo
290                 ElseIf .Invent.NudilloSlot = SlotNuevo Then
292                     .Invent.NudilloSlot = SlotViejo
    
                    End If
                     
                    'Cambiamos si alguno es un magico
294                 If .Invent.MagicoSlot = SlotViejo Then
296                     .Invent.MagicoSlot = SlotNuevo
298                 ElseIf .Invent.MagicoSlot = SlotNuevo Then
300                     .Invent.MagicoSlot = SlotViejo
    
                    End If
                     
                    'Cambiamos si alguno es una herramienta
302                 If .Invent.HerramientaEqpSlot = SlotViejo Then
304                     .Invent.HerramientaEqpSlot = SlotNuevo
306                 ElseIf .Invent.HerramientaEqpSlot = SlotNuevo Then
308                     .Invent.HerramientaEqpSlot = SlotViejo
    
                    End If
                
310                 If Objeto.ObjIndex = 0 Then
312                     .Invent.Object(SlotNuevo).ObjIndex = .Invent.Object(SlotViejo).ObjIndex
314                     .Invent.Object(SlotNuevo).amount = .Invent.Object(SlotViejo).amount
316                     .Invent.Object(SlotNuevo).Equipped = .Invent.Object(SlotViejo).Equipped
                            
318                     .Invent.Object(SlotViejo).ObjIndex = 0
320                     .Invent.Object(SlotViejo).amount = 0
322                     .Invent.Object(SlotViejo).Equipped = 0
    
                    End If
                    
                End If
                
324             Call UpdateUserInv(False, userindex, SlotViejo)
326             Call UpdateUserInv(False, userindex, SlotNuevo)

            End If

        End With
    
        Exit Sub

ErrHandler:
328     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMoveItem", Erl)
330

End Sub

Private Sub HandleBovedaMoveItem(ByVal userindex As Integer)
        'Author: Pablo Mercavides
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim SlotViejo As Byte
            Dim SlotNuevo As Byte
        
102         SlotViejo = Reader.ReadInt()
104         SlotNuevo = Reader.ReadInt()
        
            Dim Objeto    As t_Obj
            Dim Equipado  As Boolean
            Dim Equipado2 As Boolean
            Dim Equipado3 As Boolean
        
            If SlotViejo > MAX_BANCOINVENTORY_SLOTS Or SlotNuevo > MAX_BANCOINVENTORY_SLOTS Or SlotViejo <= 0 Or SlotNuevo <= 0 Then Exit Sub
106         Objeto.ObjIndex = UserList(userindex).BancoInvent.Object(SlotViejo).ObjIndex
108         Objeto.amount = UserList(userindex).BancoInvent.Object(SlotViejo).amount
        
110         UserList(userindex).BancoInvent.Object(SlotViejo).ObjIndex = UserList(userindex).BancoInvent.Object(SlotNuevo).ObjIndex
112         UserList(userindex).BancoInvent.Object(SlotViejo).amount = UserList(userindex).BancoInvent.Object(SlotNuevo).amount
         
114         UserList(userindex).BancoInvent.Object(SlotNuevo).ObjIndex = Objeto.ObjIndex
116         UserList(userindex).BancoInvent.Object(SlotNuevo).amount = Objeto.amount
    
            'Actualizamos el banco
118         Call UpdateBanUserInv(False, userindex, SlotViejo)
120         Call UpdateBanUserInv(False, userindex, SlotNuevo)

        End With
    
        Exit Sub
    
        Exit Sub

ErrHandler:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBovedaMoveItem", Erl)
124

End Sub

Private Sub HandleQuieroFundarClan(ByVal userindex As Integer)
        'Author: Pablo Mercavides

        On Error GoTo ErrHandler

100     With UserList(userindex)

102         If UserList(userindex).flags.Privilegios And e_PlayerType.Consejero Then Exit Sub

104         If UserList(userindex).GuildIndex > 0 Then
106             Call WriteConsoleMsg(userindex, "Ya perteneces a un clan, no pod�s fundar otro.", e_FontTypeNames.FONTTYPE_INFOIAO)
                Exit Sub

            End If

108         If UserList(userindex).Stats.ELV < 25 Or UserList(userindex).Stats.UserSkills(e_Skill.liderazgo) < 90 Then
110             Call WriteConsoleMsg(userindex, "Para fundar un clan debes ser nivel 25, tener 90 en liderazgo y tener en tu inventario las 2 gemas: Gema Polar(1), Gema Roja(1).", e_FontTypeNames.FONTTYPE_INFOIAO)
                Exit Sub

            End If

112         If Not TieneObjetos(407, 1, userindex) Or Not TieneObjetos(408, 1, userindex) Then
114             Call WriteConsoleMsg(userindex, "Para fundar un clan debes tener en tu inventario las 2 gemas: Gema Polar(1), Gema Roja(1).", e_FontTypeNames.FONTTYPE_INFOIAO)
                'Exit Sub

            End If

116         Call WriteConsoleMsg(userindex, "Servidor � �Comenzamos a fundar el clan! Ingresa todos los datos solicitados.", e_FontTypeNames.FONTTYPE_INFOIAO)
        
118         Call WriteShowFundarClanForm(userindex)

        End With
    
        Exit Sub
    
        Exit Sub

ErrHandler:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleQuieroFundarClan", Erl)
122

End Sub

Private Sub HandleLlamadadeClan(ByVal userindex As Integer)
        'Author: Pablo Mercavides

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim refError   As String
            Dim clan_nivel As Byte

102         If .GuildIndex <> 0 Then
104             clan_nivel = modGuilds.NivelDeClan(.GuildIndex)

106             If clan_nivel >= 2 Then
108                 Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Clan> [" & .name & "] solicita apoyo de su clan en " & get_map_name(.Pos.Map) & " (" & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y & "). Puedes ver su ubicaci�n en el mapa del mundo.", e_FontTypeNames.FONTTYPE_GUILD))
110                 Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessagePlayWave("43", NO_3D_SOUND, NO_3D_SOUND))
112                 Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageUbicacionLlamada(.Pos.Map, .Pos.X, .Pos.Y))

                Else
114                 Call WriteConsoleMsg(userindex, "Servidor � El nivel de tu clan debe ser 2 para utilizar esta opci�n.", e_FontTypeNames.FONTTYPE_INFOIAO)

                End If
            End If

        End With
    
        Exit Sub

ErrHandler:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleLlamadadeClan", Erl)
118

End Sub


Private Sub HandleGenio(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleGenio_Err

100     With UserList(userindex)

            'Si no es GM, no pasara nada :P
102         If (.flags.Privilegios And e_PlayerType.user) Then Exit Sub
        
            Dim i As Byte

104         For i = 1 To NUMSKILLS
106             .Stats.UserSkills(i) = 100
108         Next i
        
110         Call WriteConsoleMsg(userindex, "Tus skills fueron editados.", e_FontTypeNames.FONTTYPE_INFOIAO)

        End With
        
        Exit Sub

HandleGenio_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleGenio", Erl)
        
End Sub

Private Sub HandleCasamiento(ByVal userindex As Integer)

        'Author: Pablo Mercavides

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer

102         UserName = Reader.ReadString8()
104         tUser = NameIndex(UserName)
            
106         If .flags.TargetNPC > 0 Then

108             If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Revividor Then
110                 Call WriteConsoleMsg(userindex, "Primero haz click sobre un sacerdote.", e_FontTypeNames.FONTTYPE_INFO)

                Else

112                 If Distancia(.Pos, NpcList(.flags.TargetNPC).Pos) > 10 Then
114                     Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                        'Call WriteConsoleMsg(UserIndex, "El sacerdote no puede casarte debido a que est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                        
                    Else
            
116                     If tUser = userindex Then
118                         Call WriteConsoleMsg(userindex, "No pod�s casarte contigo mismo.", e_FontTypeNames.FONTTYPE_INFO)
                        
120                     ElseIf .flags.Casado = 1 Then
122                         Call WriteConsoleMsg(userindex, "�Ya est�s casado! Debes divorciarte de tu actual pareja para casarte nuevamente.", e_FontTypeNames.FONTTYPE_INFO)
                            
124                     ElseIf UserList(tUser).flags.Casado = 1 Then
126                         Call WriteConsoleMsg(userindex, "Tu pareja debe divorciarse antes de tomar tu mano en matrimonio.", e_FontTypeNames.FONTTYPE_INFO)
                            
                        Else

128                         If tUser <= 0 Then
130                             Call WriteConsoleMsg(userindex, "El usuario no esta online.", e_FontTypeNames.FONTTYPE_INFO)

                            Else

132                             If UserList(tUser).flags.Candidato = userindex Then

134                                 UserList(tUser).flags.Casado = 1
136                                 UserList(tUser).flags.Pareja = UserList(userindex).name
138                                 .flags.Casado = 1
140                                 .flags.Pareja = UserList(tUser).name

142                                 Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayWave(e_FXSound.Casamiento_sound, NO_3D_SOUND, NO_3D_SOUND))
144                                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("El sacerdote de " & get_map_name(.Pos.Map) & " celebra el casamiento entre " & UserList(userindex).name & " y " & UserList(tUser).name & ".", e_FontTypeNames.FONTTYPE_WARNING))
146                                 Call WriteChatOverHead(userindex, "Los declaro unidos en legal matrimonio �Felicidades!", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
148                                 Call WriteChatOverHead(tUser, "Los declaro unidos en legal matrimonio �Felicidades!", NpcList(UserList(userindex).flags.TargetNPC).Char.CharIndex, vbWhite)
                                
                                Else
                                
150                                 Call WriteChatOverHead(userindex, "La solicitud de casamiento a sido enviada a " & UserName & ".", NpcList(.flags.TargetNPC).Char.CharIndex, vbWhite)
152                                 Call WriteConsoleMsg(tUser, .name & " desea casarse contigo, para permitirlo haz click en el sacerdote y escribe /PROPONER " & .name & ".", e_FontTypeNames.FONTTYPE_TALK)

154                                 .flags.Candidato = tUser

                                End If

                            End If

                        End If

                    End If

                End If

            Else
156             Call WriteConsoleMsg(userindex, "Primero haz click sobre el sacerdote.", e_FontTypeNames.FONTTYPE_INFO)

            End If

        End With
    
        Exit Sub

ErrHandler:
158     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCasamiento", Erl)
160

End Sub

Private Sub HandleCrearTorneo(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)
 
            Dim NivelMinimo As Byte
            Dim nivelmaximo As Byte
        
            Dim cupos       As Byte
            Dim costo       As Long
        
            Dim mago        As Byte
            Dim clerico     As Byte
            Dim guerrero    As Byte
            Dim asesino     As Byte
            Dim bardo       As Byte
            Dim druido      As Byte
            Dim Paladin     As Byte
            Dim cazador     As Byte
            Dim Trabajador  As Byte
            Dim Pirata      As Byte
            Dim Ladron      As Byte
            Dim Bandido     As Byte

            Dim Mapa        As Integer
            Dim X           As Byte
            Dim Y           As Byte

            Dim nombre      As String
            Dim reglas      As String

102         NivelMinimo = Reader.ReadInt
104         nivelmaximo = Reader.ReadInt
        
106         cupos = Reader.ReadInt
108         costo = Reader.ReadInt
        
110         mago = Reader.ReadInt
112         clerico = Reader.ReadInt
114         guerrero = Reader.ReadInt
116         asesino = Reader.ReadInt
118         bardo = Reader.ReadInt
120         druido = Reader.ReadInt
122         Paladin = Reader.ReadInt
124         cazador = Reader.ReadInt
126         Trabajador = Reader.ReadInt
128         Pirata = Reader.ReadInt
130         Ladron = Reader.ReadInt
132         Bandido = Reader.ReadInt

134         Mapa = Reader.ReadInt
136         X = Reader.ReadInt
138         Y = Reader.ReadInt
        
140         nombre = Reader.ReadString8
142         reglas = Reader.ReadString8
  
144         If EsGM(userindex) And ((.flags.Privilegios And e_PlayerType.Consejero) = 0) Then
146             Torneo.NivelMinimo = NivelMinimo
148             Torneo.nivelmaximo = nivelmaximo
            
150             Torneo.cupos = cupos
152             Torneo.costo = costo
            
154             Torneo.mago = mago
156             Torneo.clerico = clerico
158             Torneo.guerrero = guerrero
160             Torneo.asesino = asesino
162             Torneo.bardo = bardo
164             Torneo.druido = druido
166             Torneo.Paladin = Paladin
168             Torneo.cazador = cazador
170             Torneo.Trabajador = Trabajador
172             Torneo.Pirata = Pirata
174             Torneo.Ladron = Ladron
176             Torneo.Bandido = Bandido
        
178             Torneo.Mapa = Mapa
180             Torneo.X = X
182             Torneo.Y = Y
            
184             Torneo.nombre = nombre
186             Torneo.reglas = reglas

188             Call IniciarTorneo

            End If

        End With
    
        Exit Sub

ErrHandler:
190     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCrearTorneo", Erl)
192

End Sub

Private Sub HandleComenzarTorneo(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

102         If EsGM(userindex) Then

104             Call ComenzarTorneoOk

            End If

        End With
    
        Exit Sub

ErrHandler:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleComenzarTorneo", Erl)
108

End Sub

Private Sub HandleCancelarTorneo(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

102         If EsGM(userindex) Then
104             Call ResetearTorneo

            End If

        End With
    
        Exit Sub

ErrHandler:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleComenzarTorneo", Erl)
108

End Sub

Private Sub HandleBusquedaTesoro(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Tipo As Byte
102             Tipo = Reader.ReadInt()
  
104         If (.flags.Privilegios And Not (e_PlayerType.Consejero Or e_PlayerType.user)) Then

106             Select Case Tipo

                    Case 0

108                     If Not BusquedaTesoroActiva And BusquedaRegaloActiva = False And BusquedaNpcActiva = False Then
110                         Call PerderTesoro
                        Else

112                         If BusquedaTesoroActiva Then
114                             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Eventos> Todavia nadie fue capaz de encontar el tesoro, recorda que se encuentra en " & get_map_name(TesoroNumMapa) & "(" & TesoroNumMapa & "). �Quien sera el valiente que lo encuentre?", e_FontTypeNames.FONTTYPE_TALK))
116                             Call WriteConsoleMsg(userindex, "Ya hay una busqueda del tesoro activa. El tesoro se encuentra en: " & TesoroNumMapa & "-" & TesoroX & "-" & TesoroY, e_FontTypeNames.FONTTYPE_INFO)
                            Else
118                             Call WriteConsoleMsg(userindex, "Ya hay una busqueda del tesoro activa.", e_FontTypeNames.FONTTYPE_INFO)

                            End If

                        End If

120                 Case 1

122                     If Not BusquedaRegaloActiva And BusquedaTesoroActiva = False And BusquedaNpcActiva = False Then
124                         Call PerderRegalo
                        Else

126                         If BusquedaRegaloActiva Then
128                             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Eventos> Ning�n valiente fue capaz de encontrar el item misterioso, recuerda que se encuentra en " & get_map_name(RegaloNumMapa) & "(" & RegaloNumMapa & "). �Ten cuidado!", e_FontTypeNames.FONTTYPE_TALK))
130                             Call WriteConsoleMsg(userindex, "Ya hay una busqueda del tesoro activa. El tesoro se encuentra en: " & RegaloNumMapa & "-" & RegaloX & "-" & RegaloY, e_FontTypeNames.FONTTYPE_INFO)
                            Else
132                             Call WriteConsoleMsg(userindex, "Ya hay una busqueda del tesoro activa.", e_FontTypeNames.FONTTYPE_INFO)

                            End If

                        End If

134                 Case 2

136                     If Not BusquedaNpcActiva And BusquedaTesoroActiva = False And BusquedaRegaloActiva = False Then
                            Dim Pos As t_WorldPos
138                         Pos.Map = TesoroNPCMapa(RandomNumber(1, UBound(TesoroNPCMapa)))
140                         Pos.Y = 50
142                         Pos.X = 50
144                         npc_index_evento = SpawnNpc(TesoroNPC(RandomNumber(1, UBound(TesoroNPC))), Pos, True, False, True)
146                         BusquedaNpcActiva = True
                        Else

148                         If BusquedaNpcActiva Then
150                             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Eventos> Todav�a nadie logr� matar el NPC que se encuentra en el mapa " & NpcList(npc_index_evento).Pos.Map & ".", e_FontTypeNames.FONTTYPE_TALK))
152                             Call WriteConsoleMsg(userindex, "Ya hay una busqueda de npc activo. El tesoro se encuentra en: " & NpcList(npc_index_evento).Pos.Map & "-" & NpcList(npc_index_evento).Pos.X & "-" & NpcList(npc_index_evento).Pos.Y, e_FontTypeNames.FONTTYPE_INFO)
                            Else
154                             Call WriteConsoleMsg(userindex, "Ya hay una busqueda del tesoro activa.", e_FontTypeNames.FONTTYPE_INFO)

                            End If

                        End If

                End Select
            Else
156             Call WriteConsoleMsg(userindex, "Servidor � No estas habilitado para hacer Eventos.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
    
        Exit Sub

ErrHandler:
158     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBusquedaTesoro", Erl)
160

End Sub

Private Sub HandleFlagTrabajar(ByVal userindex As Integer)
    
        On Error GoTo ErrHandler

100     With UserList(userindex)

102         .Counters.Trabajando = 0
104         .flags.UsandoMacro = False
106         .flags.TargetObj = 0 ' Sacamos el targer del objeto
108         .flags.UltimoMensaje = 0

        End With
    
        Exit Sub

ErrHandler:
110     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
112

End Sub

Private Sub HandleCompletarAccion(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Accion As Byte
102             Accion = Reader.ReadInt()
        
104         If .Accion.AccionPendiente = True Then
106             If .Accion.TipoAccion = Accion Then
108                 Call CompletarAccionFin(userindex)
                Else
110                 Call WriteConsoleMsg(userindex, "Servidor � La acci�n que solicitas no se corresponde.", e_FontTypeNames.FONTTYPE_SERVER)

                End If

            Else
112             Call WriteConsoleMsg(userindex, "Servidor � Tu no tenias ninguna acci�n pendiente. ", e_FontTypeNames.FONTTYPE_SERVER)

            End If

        End With
    
        Exit Sub

ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
116

End Sub

Private Sub HandleInvitarGrupo(ByVal userindex As Integer)

100     With UserList(userindex)

102         If .flags.Muerto = 1 Then
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!.", e_FontTypeNames.FONTTYPE_INFO)
104             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
            
            Else
            
106             If .Grupo.CantidadMiembros <= UBound(.Grupo.Miembros) Then
108                 Call WriteWorkRequestTarget(userindex, e_Skill.Grupo)
                Else
110                 Call WriteConsoleMsg(userindex, "�No pod�s invitar a m�s personas!", e_FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End With
        
        Exit Sub

HandleInvitarGrupo_Err:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleInvitarGrupo", Erl)
114
    
End Sub

Private Sub HandleMarcaDeClan(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleMarcaDeClan_Err

100     With UserList(userindex)
            'Exit sub para anular marca de clan
            Exit Sub
102         If UserList(userindex).GuildIndex = 0 Then
                Exit Sub
            End If

104         If .flags.Muerto = 1 Then
                'Call WriteConsoleMsg(UserIndex, "��Est�s muerto!!.", e_FontTypeNames.FONTTYPE_INFO)
106             Call WriteLocaleMsg(userindex, "77", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
            Dim clan_nivel As Byte

108         clan_nivel = modGuilds.NivelDeClan(UserList(userindex).GuildIndex)

110         If clan_nivel > 20 Then
112             Call WriteConsoleMsg(userindex, "Servidor � El nivel de tu clan debe ser 3 para utilizar esta opci�n.", e_FontTypeNames.FONTTYPE_INFOIAO)
                Exit Sub
            End If
       
114         Call WriteWorkRequestTarget(userindex, e_Skill.MarcaDeClan)
        
        End With
        
        Exit Sub

HandleMarcaDeClan_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMarcaDeClan", Erl)
118
End Sub

Private Sub HandleMarcaDeGM(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleMarcaDeGM_Err

100     Call WriteWorkRequestTarget(userindex, e_Skill.MarcaDeGM)

        Exit Sub

HandleMarcaDeGM_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMarcaDeGM", Erl)
104
    
End Sub

Private Sub HandleResponderPregunta(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim respuesta As Boolean
            Dim DeDonde   As String

102         respuesta = Reader.ReadBool()
        
            Dim Log As String

104         Log = "Repuesta "
            UserList(userindex).flags.RespondiendoPregunta = False
106         If respuesta Then
        
108             Select Case UserList(userindex).flags.pregunta

                    Case 1
110                     Log = "Repuesta Afirmativa 1"

                        'Call WriteConsoleMsg(UserIndex, "El usuario desea unirse al grupo.", e_FontTypeNames.FONTTYPE_SUBASTA)
                        ' UserList(UserIndex).Grupo.PropuestaDe = 0
112                     If UserList(userindex).Grupo.PropuestaDe <> 0 Then
                
114                         If UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.Lider <> UserList(userindex).Grupo.PropuestaDe Then
116                             Call WriteConsoleMsg(userindex, "�El lider del grupo a cambiado, imposible unirse!", e_FontTypeNames.FONTTYPE_INFOIAO)
                            Else
                        
118                             Log = "Repuesta Afirmativa 1-1 "
                        
120                             If UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.Lider = 0 Then
122                                 Call WriteConsoleMsg(userindex, "�El grupo ya no existe!", e_FontTypeNames.FONTTYPE_INFOIAO)
                                Else
                            
124                                 Log = "Repuesta Afirmativa 1-2 "
                            
126                                 If UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.CantidadMiembros = 1 Then
128                                     Call WriteLocaleMsg(UserList(userindex).Grupo.PropuestaDe, "36", e_FontTypeNames.FONTTYPE_INFOIAO)
                                        'Call WriteConsoleMsg(UserList(UserIndex).Grupo.PropuestaDe, "�El grupo a sido creado!", e_FontTypeNames.FONTTYPE_INFOIAO)
130                                     UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.EnGrupo = True
132                                     Log = "Repuesta Afirmativa 1-3 "

                                    End If
                                
134                                 Log = "Repuesta Afirmativa 1-4"
136                                 UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.CantidadMiembros = UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.CantidadMiembros + 1
138                                 UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.Miembros(UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.CantidadMiembros) = userindex
140                                 UserList(userindex).Grupo.EnGrupo = True
                                
                                    Dim Index As Byte
                                
142                                 Log = "Repuesta Afirmativa 1-5 "
                                
144                                 For Index = 2 To UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.CantidadMiembros - 1
146                                     Call WriteLocaleMsg(UserList(UserList(userindex).Grupo.PropuestaDe).Grupo.Miembros(Index), "40", e_FontTypeNames.FONTTYPE_INFOIAO, UserList(userindex).name)
                                
148                                 Next Index
                                
150                                 Log = "Repuesta Afirmativa 1-6 "
                                    'Call WriteConsoleMsg(UserList(UserIndex).Grupo.PropuestaDe, "�" & UserList(UserIndex).name & " a sido a�adido al grupo!", e_FontTypeNames.FONTTYPE_INFOIAO)
152                                 Call WriteLocaleMsg(UserList(userindex).Grupo.PropuestaDe, "40", e_FontTypeNames.FONTTYPE_INFOIAO, UserList(userindex).name)
                                
154                                 Call WriteConsoleMsg(userindex, "�Has sido a�adido al grupo!", e_FontTypeNames.FONTTYPE_INFOIAO)
                                
156                                 Log = "Repuesta Afirmativa 1-7 "
                                
158                                 Call RefreshCharStatus(UserList(userindex).Grupo.PropuestaDe)
160                                 Call RefreshCharStatus(userindex)
                                 
162                                 Log = "Repuesta Afirmativa 1-8"

164                                 Call CompartirUbicacion(userindex)

                                End If

                            End If

                        Else
                    
166                         Call WriteConsoleMsg(userindex, "Servidor � Solicitud de grupo invalida, reintente...", e_FontTypeNames.FONTTYPE_SERVER)
                    
                        End If

                        'unirlo
168                 Case 2
170                     Log = "Repuesta Afirmativa 2"
172                     Call WriteConsoleMsg(userindex, "�Ahora sos un ciudadano!", e_FontTypeNames.FONTTYPE_INFOIAO)
174                     Call VolverCiudadano(userindex)
                    
176                 Case 3
178                     Log = "Repuesta Afirmativa 3"
                    
180                     UserList(userindex).Hogar = UserList(userindex).PosibleHogar

182                     Select Case UserList(userindex).Hogar

                            Case e_Ciudad.cUllathorpe
184                             DeDonde = "Ullathorpe"
                            
186                         Case e_Ciudad.cNix
188                             DeDonde = "Nix"
                
190                         Case e_Ciudad.cBanderbill
192                             DeDonde = "Banderbill"
                        
194                         Case e_Ciudad.cLindos 'Vamos a tener que ir por todo el desierto... uff!
196                             DeDonde = "Lindos"
                            
198                         Case e_Ciudad.cArghal
200                             DeDonde = " Arghal"
                            
202                         Case e_Ciudad.cArkhein
204                             DeDonde = " Arkhein"
                            
206                         Case Else
208                             DeDonde = "Ullathorpe"

                        End Select
                    
210                     If UserList(userindex).flags.TargetNPC <> 0 Then
                    
212                         Call WriteChatOverHead(userindex, "�Gracias " & UserList(userindex).name & "! Ahora perteneces a la ciudad de " & DeDonde & ".", NpcList(UserList(userindex).flags.TargetNPC).Char.CharIndex, vbWhite)
                        Else
214                         Call WriteConsoleMsg(userindex, "�Gracias " & UserList(userindex).name & "! Ahora perteneces a la ciudad de " & DeDonde & ".", e_FontTypeNames.FONTTYPE_INFOIAO)

                        End If
                    
216                 Case 4
218                     Log = "Repuesta Afirmativa 4"
                
220                     If UserList(userindex).flags.TargetUser <> 0 Then
                
222                         UserList(userindex).ComUsu.DestUsu = UserList(userindex).flags.TargetUser
224                         UserList(userindex).ComUsu.DestNick = UserList(UserList(userindex).flags.TargetUser).name
226                         UserList(userindex).ComUsu.cant = 0
228                         UserList(userindex).ComUsu.Objeto = 0
230                         UserList(userindex).ComUsu.Acepto = False
                    
                            'Rutina para comerciar con otro usuario
232                         Call IniciarComercioConUsuario(userindex, UserList(userindex).flags.TargetUser)

                        Else
234                         Call WriteConsoleMsg(userindex, "Servidor � Solicitud de comercio invalida, reintente...", e_FontTypeNames.FONTTYPE_SERVER)
                
                        End If
                
                    Case 5
                        Dim i As Integer, j As Integer
                        
                        With UserList(userindex)
                            For i = 1 To MAX_INVENTORY_SLOTS
                                For j = 1 To UBound(PecesEspeciales)
                                    If .Invent.Object(i).ObjIndex = PecesEspeciales(j).ObjIndex Then
                                        .Stats.PuntosPesca = .Stats.PuntosPesca + (ObjData(.Invent.Object(i).ObjIndex).PuntosPesca * .Invent.Object(i).amount)
                                        Call QuitarUserInvItem(userindex, i, .Invent.Object(i).amount)
                                        Call UpdateUserInv(False, userindex, i)
                                    End If
                                Next j
                            Next i
                            Dim charIndexStr As Integer
                            charIndexStr = str(NpcList(UserList(userindex).flags.TargetNPC).Char.CharIndex)
                            If charIndexStr > 0 Then
                                Call WriteChatOverHead(userindex, "Felicitaciones! Ahora tienes un total de " & .Stats.PuntosPesca & " puntos de pesca.", charIndexStr, &HFFFF00)
                            End If
                            .flags.pregunta = 0
                        End With
                                                
236
262                 Case Else
264                     Call WriteConsoleMsg(userindex, "No tienes preguntas pendientes.", e_FontTypeNames.FONTTYPE_INFOIAO)

                        
                End Select
        
            Else
266             Log = "Repuesta negativa"
        
268             Select Case UserList(userindex).flags.pregunta

                    Case 1
270                     Log = "Repuesta negativa 1"

272                     If UserList(userindex).Grupo.PropuestaDe <> 0 Then
274                         Call WriteConsoleMsg(UserList(userindex).Grupo.PropuestaDe, "El usuario no esta interesado en formar parte del grupo.", e_FontTypeNames.FONTTYPE_INFOIAO)

                        End If

276                     UserList(userindex).Grupo.PropuestaDe = 0
278                     Call WriteConsoleMsg(userindex, "Has rechazado la propuesta.", e_FontTypeNames.FONTTYPE_INFOIAO)
                
280                 Case 2
282                     Log = "Repuesta negativa 2"
284                     Call WriteConsoleMsg(userindex, "�Continuas siendo neutral!", e_FontTypeNames.FONTTYPE_INFOIAO)
286                     Call VolverCriminal(userindex)

288                 Case 3
290                     Log = "Repuesta negativa 3"
                    
292                     Select Case UserList(userindex).PosibleHogar

                            Case e_Ciudad.cUllathorpe
294                             DeDonde = "Ullathorpe"
                            
296                         Case e_Ciudad.cNix
298                             DeDonde = "Nix"
                
300                         Case e_Ciudad.cBanderbill
302                             DeDonde = "Banderbill"
                        
304                         Case e_Ciudad.cLindos 'Vamos a tener que ir por todo el desierto... uff!
306                             DeDonde = "Lindos"
                            
308                         Case e_Ciudad.cArghal
310                             DeDonde = " Arghal"
                            
312                         Case e_Ciudad.cArkhein
314                             DeDonde = " Arkhein"
                            
316                         Case Else
318                             DeDonde = "Ullathorpe"

                        End Select
                    
320                     If UserList(userindex).flags.TargetNPC <> 0 Then
322                         Call WriteChatOverHead(userindex, "�No hay problema " & UserList(userindex).name & "! Sos bienvenido en " & DeDonde & " cuando gustes.", NpcList(UserList(userindex).flags.TargetNPC).Char.CharIndex, vbWhite)

                        End If

324                     UserList(userindex).PosibleHogar = UserList(userindex).Hogar
                    
326                 Case 4
328                     Log = "Repuesta negativa 4"
                    
330                     If UserList(userindex).flags.TargetUser <> 0 Then
332                         Call WriteConsoleMsg(UserList(userindex).flags.TargetUser, "El usuario no desea comerciar en este momento.", e_FontTypeNames.FONTTYPE_INFO)

                        End If

334                 Case 5
336                     Log = "Repuesta negativa 5"
                        'No hago nada. dijo que no lo resucite
                        
338                 Case Else
340                     Call WriteConsoleMsg(userindex, "No tienes preguntas pendientes.", e_FontTypeNames.FONTTYPE_INFOIAO)

                End Select
            
            End If

        End With
    
        Exit Sub
    
ErrHandler:
342     Call TraceError(Err.Number, Err.Description, "Protocol.HandleResponderPregunta", Erl)
344

End Sub

Private Sub HandleRequestGrupo(ByVal userindex As Integer)

        On Error GoTo hErr

        'Author: Pablo Mercavides

100     Call WriteDatosGrupo(userindex)
    
        Exit Sub
    
hErr:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRequestGrupo", Erl)
104

End Sub

Private Sub HandleAbandonarGrupo(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleAbandonarGrupo_Err

100     With UserList(userindex)

        
102         Call Reader.ReadInt
        
104         If UserList(userindex).Grupo.Lider = userindex Then
            
106             Call FinalizarGrupo(userindex)

                Dim i As Byte
            
108             For i = 2 To UserList(userindex).Grupo.CantidadMiembros
110                 Call WriteUbicacion(userindex, i, 0)
112             Next i

114             UserList(userindex).Grupo.CantidadMiembros = 0
116             UserList(userindex).Grupo.EnGrupo = False
118             UserList(userindex).Grupo.Lider = 0
120             UserList(userindex).Grupo.PropuestaDe = 0
122             Call WriteConsoleMsg(userindex, "Has disuelto el grupo.", e_FontTypeNames.FONTTYPE_INFOIAO)
124             Call RefreshCharStatus(userindex)
            
            Else
126             Call SalirDeGrupo(userindex)

            End If

        End With
        
        Exit Sub

HandleAbandonarGrupo_Err:
128     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAbandonarGrupo", Erl)
130
    
End Sub

Private Sub HandleHecharDeGrupo(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleHecharDeGrupo_Err

100     With UserList(userindex)

            Dim Indice As Byte

102         Indice = Reader.ReadInt()
        
104         Call EcharMiembro(userindex, Indice)

        End With
        
        Exit Sub

HandleHecharDeGrupo_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleHecharDeGrupo", Erl)
108
    
End Sub

Private Sub HandleMacroPos(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleMacroPos_Err

100     With UserList(userindex)

102         .ChatCombate = Reader.ReadInt()
104         .ChatGlobal = Reader.ReadInt()

        End With
        
        Exit Sub

HandleMacroPos_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMacroPos", Erl)
108
    
End Sub

Private Sub HandleSubastaInfo(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleSubastaInfo_Err

100     With UserList(userindex)

102         If Subasta.HaySubastaActiva Then

104             Call WriteConsoleMsg(userindex, "Subastador: " & Subasta.Subastador, e_FontTypeNames.FONTTYPE_SUBASTA)
106             Call WriteConsoleMsg(userindex, "Objeto: " & ObjData(Subasta.ObjSubastado).name & " (" & Subasta.ObjSubastadoCantidad & ")", e_FontTypeNames.FONTTYPE_SUBASTA)

108             If Subasta.HuboOferta Then
110                 Call WriteConsoleMsg(userindex, "Mejor oferta: " & PonerPuntos(Subasta.MejorOferta) & " monedas de oro por " & Subasta.Comprador & ".", e_FontTypeNames.FONTTYPE_SUBASTA)
112                 Call WriteConsoleMsg(userindex, "Podes realizar una oferta escribiendo /OFERTAR " & PonerPuntos(Subasta.MejorOferta + 100), e_FontTypeNames.FONTTYPE_SUBASTA)
                Else
114                 Call WriteConsoleMsg(userindex, "Oferta inicial: " & PonerPuntos(Subasta.OfertaInicial) & " monedas de oro.", e_FontTypeNames.FONTTYPE_SUBASTA)
116                 Call WriteConsoleMsg(userindex, "Podes realizar una oferta escribiendo /OFERTAR " & PonerPuntos(Subasta.OfertaInicial + 100), e_FontTypeNames.FONTTYPE_SUBASTA)

                End If

118             Call WriteConsoleMsg(userindex, "Tiempo Restante de subasta:  " & SumarTiempo(Subasta.TiempoRestanteSubasta), e_FontTypeNames.FONTTYPE_SUBASTA)
            
            Else
120             Call WriteConsoleMsg(userindex, "No hay ninguna subasta activa en este momento.", e_FontTypeNames.FONTTYPE_SUBASTA)

            End If

        End With
        
        Exit Sub

HandleSubastaInfo_Err:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleSubastaInfo", Erl)
124
End Sub

Private Sub HandleCancelarExit(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleCancelarExit_Err

100     Call CancelExit(userindex)
        
        Exit Sub

HandleCancelarExit_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCancelarExit", Erl)
104
        
End Sub

Private Sub HandleBanCuenta(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim Reason   As String
        
102         UserName = Reader.ReadString8()
104         Reason = Reader.ReadString8()
        
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) Then
108             Call BanearCuenta(userindex, UserName, Reason)
            Else
110             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
112     Call TraceError(Err.Number, Err.Description, "Protocol.HandleBanCuenta", Erl)
114

End Sub

Private Sub HandleUnBanCuenta(ByVal userindex As Integer)

        ' /unbancuenta namepj
        ' /unbancuenta email
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserNameOEmail As String
102         UserNameOEmail = Reader.ReadString8()
        
104         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) Then
116             If DesbanearCuenta(userindex, UserNameOEmail) Then
118                 Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor � " & .name & " ha desbaneado la cuenta de " & UserNameOEmail & ".", e_FontTypeNames.FONTTYPE_SERVER))
                Else
                    Call WriteConsoleMsg(userindex, "No se ha podido desbanear la cuenta.", e_FontTypeNames.FONTTYPE_INFO)
                End If
            Else
120             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
122     Call TraceError(Err.Number, Err.Description, "Protocol.HandleUnBanCuenta", Erl)
124

End Sub

Private Sub HandleCerrarCliente(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim UserName As String
            Dim tUser    As Integer
         
102         UserName = Reader.ReadString8()
        
            ' Solo administradores pueden cerrar clientes ajenos
104         If (.flags.Privilegios And e_PlayerType.Admin) Then

106             tUser = NameIndex(UserName)
            
108             If tUser <= 0 Then
110                 Call WriteConsoleMsg(userindex, "El usuario no esta online.", e_FontTypeNames.FONTTYPE_INFO)
                Else
112                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.name & " cerro el cliente de " & UserName & ".", e_FontTypeNames.FONTTYPE_INFO))
                    
114                 Call WriteCerrarleCliente(tUser)

116                 Call LogGM(.name, "Cerro el cliene de:" & UserName)

                End If

            End If

        End With

        Exit Sub

ErrHandler:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCerrarCliente", Erl)
120

End Sub

Private Sub HandleEventoInfo(ByVal userindex As Integer)
        'Author: Pablo Mercavides
        
        On Error GoTo HandleEventoInfo_Err

100     With UserList(userindex)

102         If EventoActivo Then
104             Call WriteConsoleMsg(userindex, PublicidadEvento & ". Tiempo restante: " & TiempoRestanteEvento & " minuto(s).", e_FontTypeNames.FONTTYPE_New_Eventos)
            Else
106             Call WriteConsoleMsg(userindex, "Eventos> Actualmente no hay ningun evento en curso.", e_FontTypeNames.FONTTYPE_New_Eventos)

            End If
        
            Dim i           As Byte
            Dim encontre    As Boolean
            Dim HoraProximo As Byte
   
108         If Not HoraEvento + 1 >= 24 Then
   
110             For i = HoraEvento + 1 To 23

112                 If Evento(i).Tipo <> 0 Then
114                     encontre = True
116                     HoraProximo = i
                        Exit For

                    End If

118             Next i

            End If
        
120         If encontre = False Then

122             For i = 0 To HoraEvento

124                 If Evento(i).Tipo <> 0 Then
126                     encontre = True
128                     HoraProximo = i
                        Exit For

                    End If

130             Next i

            End If
        
132         If encontre Then
134             Call WriteConsoleMsg(userindex, "Eventos> El proximo evento " & DescribirEvento(HoraProximo) & " iniciara a las " & HoraProximo & ":00 horas.", e_FontTypeNames.FONTTYPE_New_Eventos)
            Else
136             Call WriteConsoleMsg(userindex, "Eventos> No hay eventos proximos.", e_FontTypeNames.FONTTYPE_New_Eventos)

            End If

        End With
        
        Exit Sub

HandleEventoInfo_Err:
138     Call TraceError(Err.Number, Err.Description, "Protocol.HandleEventoInfo", Erl)
140
End Sub

Private Sub HandleCrearEvento(ByVal userindex As Integer)

        '***************************************************
        'Author: Pablo Mercavides
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Tipo           As Byte
            Dim Duracion       As Byte
            Dim multiplicacion As Byte
        
102         Tipo = Reader.ReadInt()
104         Duracion = Reader.ReadInt()
106         multiplicacion = Reader.ReadInt()

108         If multiplicacion > 5 Then 'no superar este multiplicador
110             multiplicacion = 2
            End If
        
            '/ dejar solo Administradores
112         If .flags.Privilegios >= e_PlayerType.Admin Then
114             If EventoActivo = False Then
116                 If LenB(Tipo) = 0 Or LenB(Duracion) = 0 Or LenB(multiplicacion) = 0 Then
118                     Call WriteConsoleMsg(userindex, "Utilice /CREAREVENTO TIPO@DURACION@MULTIPLICACION.", e_FontTypeNames.FONTTYPE_New_Eventos)
                    Else
                
120                     Call ForzarEvento(Tipo, Duracion, multiplicacion, UserList(userindex).name)
                  
                    End If

                Else
122                 Call WriteConsoleMsg(userindex, "Ya hay un evento en curso. Finalicelo con /FINEVENTO primero.", e_FontTypeNames.FONTTYPE_New_Eventos)

                End If
            Else
124             Call WriteConsoleMsg(userindex, "Servidor � Solo Administradores pueder crear estos eventos.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
    
        Exit Sub

ErrHandler:
126     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
128

End Sub

Private Sub HandleBanTemporal(ByVal userindex As Integer)

        '***************************************************
        'Author: Nicolas Matias Gonzalez (NIGO)
        'Last Modification: 12/29/06
        '
        '***************************************************

        On Error GoTo ErrHandler

100     With UserList(userindex)
         
            Dim UserName As String
            Dim Reason   As String
            Dim dias     As Byte
        
102         UserName = Reader.ReadString8()
104         Reason = Reader.ReadString8()
106         dias = Reader.ReadInt()
        
108         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios Or e_PlayerType.SemiDios)) Then
110             Call Admin.BanTemporal(UserName, dias, Reason, UserList(userindex).name)
            Else
112             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With

        Exit Sub

ErrHandler:
114     Call TraceError(Err.Number, Err.Description, "Protocol.?", Erl)
116

End Sub

Private Sub HandleCompletarViaje(ByVal userindex As Integer)
        'Author: Pablo Mercavides

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim Destino As Byte

            Dim costo   As Long

102         Destino = Reader.ReadInt()
104         costo = Reader.ReadInt()

            ' WyroX: WTF el costo lo decide el cliente... Desactivo....
            Exit Sub

106         If costo <= 0 Then Exit Sub

            Dim DeDonde As t_CityWorldPos

108         If UserList(userindex).Stats.GLD < costo Then
110             Call WriteConsoleMsg(userindex, "No tienes suficiente dinero.", e_FontTypeNames.FONTTYPE_INFO)
            
            Else

112             Select Case Destino

                    Case e_Ciudad.cUllathorpe
114                     DeDonde = CityUllathorpe
                        
116                 Case e_Ciudad.cNix
118                     DeDonde = CityNix
            
120                 Case e_Ciudad.cBanderbill
122                     DeDonde = CityBanderbill
                    
124                 Case e_Ciudad.cLindos 'Vamos a tener que ir por todo el desierto... uff!
126                     DeDonde = CityLindos
                        
128                 Case e_Ciudad.cArghal
130                     DeDonde = CityArghal
                        
132                 Case e_Ciudad.cArkhein
134                     DeDonde = CityArkhein
                        
136                 Case Else
138                     DeDonde = CityUllathorpe

                End Select
        
140             If DeDonde.NecesitaNave > 0 Then
142                 If UserList(userindex).Stats.UserSkills(e_Skill.Navegacion) < 80 Then
                        Rem Call WriteConsoleMsg(UserIndex, "Debido a la peligrosidad del viaje, no puedo llevarte, ya que al menos necesitas saber manejar una barca.", e_FontTypeNames.FONTTYPE_INFO)
144                     Call WriteConsoleMsg(userindex, "Debido a la peligrosidad del viaje, no puedo llevarte, ya que al menos necesitas saber manejar una barca.", e_FontTypeNames.FONTTYPE_WARNING)
                    Else

146                     If UserList(userindex).flags.TargetNPC <> 0 Then
148                         If NpcList(UserList(userindex).flags.TargetNPC).SoundClose <> 0 Then
150                             Call WritePlayWave(userindex, NpcList(UserList(userindex).flags.TargetNPC).SoundClose, NO_3D_SOUND, NO_3D_SOUND)

                            End If

                        End If

152                     Call WarpToLegalPos(userindex, DeDonde.MapaViaje, DeDonde.ViajeX, DeDonde.ViajeY, True)
154                     Call WriteConsoleMsg(userindex, "Has viajado por varios d�as, te sientes exhausto!", e_FontTypeNames.FONTTYPE_WARNING)
156                     UserList(userindex).Stats.MinAGU = 0
158                     UserList(userindex).Stats.MinHam = 0
                    
164                     UserList(userindex).Stats.GLD = UserList(userindex).Stats.GLD - costo
166                     Call WriteUpdateHungerAndThirst(userindex)
168                     Call WriteUpdateUserStats(userindex)

                    End If

                Else
            
                    Dim Map As Integer

                    Dim X   As Byte

                    Dim Y   As Byte
            
170                 Map = DeDonde.MapaViaje
172                 X = DeDonde.ViajeX
174                 Y = DeDonde.ViajeY

176                 If UserList(userindex).flags.TargetNPC <> 0 Then
178                     If NpcList(UserList(userindex).flags.TargetNPC).SoundClose <> 0 Then
180                         Call WritePlayWave(userindex, NpcList(UserList(userindex).flags.TargetNPC).SoundClose, NO_3D_SOUND, NO_3D_SOUND)

                        End If

                    End If
                
182                 Call WarpUserChar(userindex, Map, X, Y, True)
184                 Call WriteConsoleMsg(userindex, "Has viajado por varios d�as, te sientes exhausto!", e_FontTypeNames.FONTTYPE_WARNING)
186                 UserList(userindex).Stats.MinAGU = 0
188                 UserList(userindex).Stats.MinHam = 0
                
194                 UserList(userindex).Stats.GLD = UserList(userindex).Stats.GLD - costo
196                 Call WriteUpdateHungerAndThirst(userindex)
198                 Call WriteUpdateUserStats(userindex)
        
                End If

            End If

        End With
    
        Exit Sub

ErrHandler:
200     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCompletarViaje", Erl)
202

End Sub

Public Sub HandleQuest(ByVal userindex As Integer)
        
        On Error GoTo HandleQuest_Err

        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        'Maneja el paquete Quest.
        'Last modified: 28/01/2010 by Amraphen
        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        Dim NpcIndex As Integer
        Dim tmpByte  As Byte

100     NpcIndex = UserList(userindex).flags.TargetNPC
    
102     If NpcIndex = 0 Then Exit Sub
    
        'Esta el personaje en la distancia correcta?
104     If Distancia(UserList(userindex).Pos, NpcList(NpcIndex).Pos) > 5 Then
106         Call WriteConsoleMsg(userindex, "Estas demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If
    
        'El NPC hace quests?
108     If NpcList(NpcIndex).NumQuest = 0 Then
110         Call SendData(SendTarget.ToIndex, userindex, PrepareMessageChatOverHead("No tengo ninguna misi�n para ti.", NpcList(NpcIndex).Char.CharIndex, vbWhite))
            Exit Sub

        End If
    
112     Call SendData(SendTarget.ToIndex, userindex, PrepareMessageChatOverHead("Estas haciendo demasiadas misiones. Vuelve cuando hayas completado alguna.", NpcList(NpcIndex).Char.CharIndex, vbWhite))

        Exit Sub

HandleQuest_Err:
114     Call TraceError(Err.Number, Err.Description, "Protocol.HandleQuest", Erl)
116
        
End Sub

Public Sub HandleQuestAccept(ByVal userindex As Integer)
        
        On Error GoTo HandleQuestAccept_Err

        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        'Maneja el evento de aceptar una quest.
        'Last modified: 31/01/2010 by Amraphen
        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        Dim NpcIndex  As Integer
        Dim QuestSlot As Byte
        Dim Indice    As Byte
        
100     Indice = Reader.ReadInt
        
102     NpcIndex = UserList(userindex).flags.TargetNPC

    
104     If NpcIndex = 0 And UserList(userindex).flags.QuestOpenByObj = False Then Exit Sub
        
        If NpcIndex > 0 Then
            If QuestList(NpcList(NpcIndex).QuestNumber(Indice)).Trabajador And UserList(userindex).clase <> e_Class.Trabajador Then
                Call WriteConsoleMsg(userindex, "La quest es solo para trabajadores.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
            
            
108         If Distancia(UserList(userindex).Pos, NpcList(NpcIndex).Pos) > 5 Then
110             Call WriteConsoleMsg(userindex, "Estas demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
            
            
112         If TieneQuest(userindex, NpcList(NpcIndex).QuestNumber(Indice)) Then
114             Call WriteConsoleMsg(userindex, "La quest ya esta en curso.", e_FontTypeNames.FONTTYPE_INFOIAO)
                Exit Sub
            End If
            
            'El personaje completo la quest que requiere?
116         If QuestList(NpcList(NpcIndex).QuestNumber(Indice)).RequiredQuest > 0 Then
118             If Not UserDoneQuest(userindex, QuestList(NpcList(NpcIndex).QuestNumber(Indice)).RequiredQuest) Then
120                 Call WriteChatOverHead(userindex, "Debes completar la quest " & QuestList(QuestList(NpcList(NpcIndex).QuestNumber(Indice)).RequiredQuest).nombre & " para emprender esta misi�n.", NpcList(NpcIndex).Char.CharIndex, vbYellow)
                    Exit Sub
    
                End If
    
            End If
    
            'El personaje tiene suficiente nivel?
122         If UserList(userindex).Stats.ELV < QuestList(NpcList(NpcIndex).QuestNumber(Indice)).RequiredLevel Then
124             Call WriteChatOverHead(userindex, "Debes ser por lo menos nivel " & QuestList(NpcList(NpcIndex).QuestNumber(Indice)).RequiredLevel & " para emprender esta misi�n.", NpcList(NpcIndex).Char.CharIndex, vbYellow)
                Exit Sub
    
            End If
            
            'La quest no es repetible?
            If QuestList(NpcList(NpcIndex).QuestNumber(Indice)).Repetible = 0 Then
                'El personaje ya hizo la quest?
126             If UserDoneQuest(userindex, NpcList(NpcIndex).QuestNumber(Indice)) Then
128                 Call WriteChatOverHead(userindex, "QUESTNEXT*" & NpcList(NpcIndex).QuestNumber(Indice), NpcList(NpcIndex).Char.CharIndex, vbYellow)
                    Exit Sub
        
                End If
            End If
        
130         QuestSlot = FreeQuestSlot(userindex)
    
132         If QuestSlot = 0 Then
134             Call WriteChatOverHead(userindex, "Debes completar las misiones en curso para poder aceptar m�s misiones.", NpcList(NpcIndex).Char.CharIndex, vbYellow)
                Exit Sub
    
            End If
        
            'Agregamos la quest.
136         With UserList(userindex).QuestStats.Quests(QuestSlot)
                
                .QuestIndex = NpcList(NpcIndex).QuestNumber(Indice)
                '.QuestIndex = UserList(UserIndex).flags.QuestNumber
            
140             If QuestList(.QuestIndex).RequiredNPCs Then ReDim .NPCsKilled(1 To QuestList(.QuestIndex).RequiredNPCs)
142             If QuestList(.QuestIndex).RequiredTargetNPCs Then ReDim .NPCsTarget(1 To QuestList(.QuestIndex).RequiredTargetNPCs)
                UserList(userindex).flags.ModificoQuests = True
                
144             Call WriteConsoleMsg(userindex, "Has aceptado la misi�n " & Chr(34) & QuestList(.QuestIndex).nombre & Chr(34) & ".", e_FontTypeNames.FONTTYPE_INFOIAO)
146
                If (FinishQuestCheck(userindex, .QuestIndex, QuestSlot)) Then
                    Call WriteUpdateNPCSimbolo(userindex, NpcIndex, 3)
                Else
                    Call WriteUpdateNPCSimbolo(userindex, NpcIndex, 4)
                End If
                
            End With
        Else
            
        End If
        Exit Sub

HandleQuestAccept_Err:
148     Call TraceError(Err.Number, Err.Description, "Protocol.HandleQuestAccept", Erl)
150
        
End Sub

Public Sub HandleQuestDetailsRequest(ByVal userindex As Integer)
        
        On Error GoTo HandleQuestDetailsRequest_Err

        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        'Maneja el paquete QuestInfoRequest.
        'Last modified: 30/01/2010 by Amraphen
        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        Dim QuestSlot As Byte

100     QuestSlot = Reader.ReadInt
        If QuestSlot <= MAXUSERQUESTS And QuestSlot > 0 Then
            If UserList(userindex).QuestStats.Quests(QuestSlot).QuestIndex > 0 Then
102             Call WriteQuestDetails(userindex, UserList(userindex).QuestStats.Quests(QuestSlot).QuestIndex, QuestSlot)
            End If
        End If
        Exit Sub

HandleQuestDetailsRequest_Err:
104     Call TraceError(Err.Number, Err.Description, "Protocol.HandleQuestDetailsRequest", Erl)
106
        
End Sub
 
Public Sub HandleQuestAbandon(ByVal userindex As Integer)
        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        'Maneja el paquete QuestAbandon.
        'Last modified: 31/01/2010 by Amraphen
        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

        On Error GoTo HandleQuestAbandon_Err
        
        With UserList(userindex)
        
            Dim Slot As Byte
            Slot = Reader.ReadInt
            
            If Slot > MAXUSERQUESTS Then Exit Sub
            
            With .QuestStats.Quests(Slot)
                ' Le quitamos los objetos de quest que no puede tirar
                If QuestList(.QuestIndex).RequiredOBJs Then
                
                    Dim ObjIndex As Integer, i As Integer
                    
                    For i = 1 To QuestList(.QuestIndex).RequiredOBJs
                        ObjIndex = QuestList(.QuestIndex).RequiredOBJ(i).ObjIndex
                        
                        If ObjData(ObjIndex).Intirable = 1 And ObjData(ObjIndex).Instransferible Then
                        
                            ' Revisamos que ninguna otra quest que tenga activa le pida el mismo item
                            Dim q As Integer, j As Byte, K As Byte, QuitarItem As Boolean

                            QuitarItem = True
                            
                            For j = 1 To MAXUSERQUESTS
                                q = UserList(userindex).QuestStats.Quests(j).QuestIndex
                                If q <> 0 And q <> .QuestIndex Then
                                    For K = 1 To QuestList(q).RequiredOBJs
                                        If QuestList(q).RequiredOBJ(K).ObjIndex = ObjIndex Then
                                            QuitarItem = False
                                            Exit For
                                        End If
                                    Next
                                End If
                                If Not QuitarItem Then Exit For
                            Next
                            
                            If QuitarItem Then
                                Call QuitarObjetos(ObjIndex, MAX_INVENTORY_OBJS, userindex)
                            End If
                        End If
                    Next i
                
                End If
            End With
    
            'Borramos la quest.
100         Call CleanQuestSlot(userindex, Slot)
        
            'Ordenamos la lista de quests del usuario.
102         Call ArrangeUserQuests(userindex)
        
            'Enviamos la lista de quests actualizada.
104         Call WriteQuestListSend(userindex)

        End With
        
        Exit Sub

HandleQuestAbandon_Err:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleQuestAbandon", Erl)
108
        
End Sub

Public Sub HandleQuestListRequest(ByVal userindex As Integer)
        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        'Maneja el paquete QuestListRequest.
        'Last modified: 30/01/2010 by Amraphen
        '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        
        On Error GoTo HandleQuestListRequest_Err

100     Call WriteQuestListSend(userindex)
        
        Exit Sub

HandleQuestListRequest_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleQuestListRequest", Erl)
104
        
End Sub

''
' Handles the "Consulta" message.
'
' @param    userIndex The index of the user sending the message.

Private Sub HandleConsulta(ByVal userindex As Integer)
        '***************************************************
        'Author: ZaMa
        'Last Modification: 01/05/2010
        'Habilita/Deshabilita el modo consulta.
        '01/05/2010: ZaMa - Agrego validaciones.
        '16/09/2010: ZaMa - No se hace visible en los clientes si estaba navegando (porque ya lo estaba).
        '***************************************************

        Dim UserConsulta As Integer
    
100     With UserList(userindex)
 
            Dim Nick As String
102         Nick = Reader.ReadString8

            ' Comando exclusivo para gms
104         If Not EsGM(userindex) Then Exit Sub
        
106         If Len(Nick) <> 0 Then
108             UserConsulta = NameIndex(Nick)
            
                'Se asegura que el target exista
110             If UserConsulta <= 0 Then
112                 Call WriteConsoleMsg(userindex, "El usuario se encuentra offline.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
    
                End If
            
            Else
        
114             UserConsulta = .flags.TargetUser
            
                'Se asegura que el target exista
116             If UserConsulta <= 0 Then
118                 Call WriteConsoleMsg(userindex, "Primero tienes que seleccionar un usuario, haz click izquierdo sobre el.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
    
                End If
            
            End If

            ' No podes ponerte a vos mismo en modo consulta.
120         If UserConsulta = userindex Then Exit Sub
        
            ' No podes estra en consulta con otro gm
122         If EsGM(UserConsulta) Then
124             Call WriteConsoleMsg(userindex, "No puedes iniciar el modo consulta con otro administrador.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

            ' Si ya estaba en consulta, termina la consulta
126         If UserList(UserConsulta).flags.EnConsulta Then
128             Call WriteConsoleMsg(userindex, "Has terminado el modo consulta con " & UserList(UserConsulta).name & ".", e_FontTypeNames.FONTTYPE_INFOBOLD)
130             Call WriteConsoleMsg(UserConsulta, "Has terminado el modo consulta.", e_FontTypeNames.FONTTYPE_INFOBOLD)
            
132             Call LogGM(.name, "Termino consulta con " & UserList(UserConsulta).name)
            
134             UserList(UserConsulta).flags.EnConsulta = False
        
                ' Sino la inicia
            Else
        
136             Call WriteConsoleMsg(userindex, "Has iniciado el modo consulta con " & UserList(UserConsulta).name & ".", e_FontTypeNames.FONTTYPE_INFOBOLD)
138             Call WriteConsoleMsg(UserConsulta, "Has iniciado el modo consulta.", e_FontTypeNames.FONTTYPE_INFOBOLD)
            
140             Call LogGM(.name, "Inicio consulta con " & UserList(UserConsulta).name)
            
142             With UserList(UserConsulta)

144                 If Not EstaPCarea(userindex, UserConsulta) Then
                        Dim X As Byte
                        Dim Y As Byte
                        
146                     X = .Pos.X
148                     Y = .Pos.Y
150                     Call FindLegalPos(userindex, .Pos.Map, X, Y)
152                     Call WarpUserChar(userindex, .Pos.Map, X, Y, True)
                        
                    End If
            
154                 If UserList(userindex).flags.AdminInvisible = 1 Then
156                     Call DoAdminInvisible(userindex)

                    End If

158                 .flags.EnConsulta = True
                
                    ' Pierde invi u ocu
160                 If .flags.invisible = 1 Or .flags.Oculto = 1 Then
                
162                     .flags.Oculto = 0
                        .Counters.TiempoOcultar = 1
164                     .flags.invisible = 0
166                     .Counters.TiempoOculto = 0
168                     .Counters.Invisibilidad = 0
                    
170                     If UserList(UserConsulta).flags.Navegando = 0 Then
                            
172                         Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageSetInvisible(.Char.CharIndex, False))

                        End If

                    End If

                End With

            End If
        
174         Call SetModoConsulta(UserConsulta)

        End With
    
        Exit Sub
    
ErrHandler:
176     Call TraceError(Err.Number, Err.Description, "Protocol.HandleConsulta", Erl)
178

End Sub

Private Sub HandleGetMapInfo(ByVal userindex As Integer)

100     With UserList(userindex)

102         If EsGM(userindex) Then
            
                Dim Response As String
            
104             Response = "[Info de mapa " & .Pos.Map & "]" & vbNewLine
106             Response = Response & "Nombre = " & MapInfo(.Pos.Map).map_name & vbNewLine
108             Response = Response & "Seguro = " & MapInfo(.Pos.Map).Seguro & vbNewLine
110             Response = Response & "Newbie = " & MapInfo(.Pos.Map).Newbie & vbNewLine
112             Response = Response & "Nivel = " & MapInfo(.Pos.Map).MinLevel & "/" & MapInfo(.Pos.Map).MaxLevel & vbNewLine
114             Response = Response & "SinInviOcul = " & MapInfo(.Pos.Map).SinInviOcul & vbNewLine
116             Response = Response & "SinMagia = " & MapInfo(.Pos.Map).SinMagia & vbNewLine
118             Response = Response & "SoloClanes = " & MapInfo(.Pos.Map).SoloClanes & vbNewLine
120             Response = Response & "NoPKs = " & MapInfo(.Pos.Map).NoPKs & vbNewLine
122             Response = Response & "NoCiudadanos = " & MapInfo(.Pos.Map).NoCiudadanos & vbNewLine
124             Response = Response & "Salida = " & MapInfo(.Pos.Map).Salida.Map & "-" & MapInfo(.Pos.Map).Salida.X & "-" & MapInfo(.Pos.Map).Salida.Y & vbNewLine
126             Response = Response & "Terreno = " & MapInfo(.Pos.Map).terrain & vbNewLine
128             Response = Response & "NoCiudadanos = " & MapInfo(.Pos.Map).NoCiudadanos & vbNewLine
130             Response = Response & "Zona = " & MapInfo(.Pos.Map).zone & vbNewLine
            
132             Call WriteConsoleMsg(userindex, Response, e_FontTypeNames.FONTTYPE_INFO)
        
            End If
    
        End With

End Sub

''
' Handles the "Denounce" message.
'
' @param    UserIndex The index of the user sending the message.

Private Sub HandleDenounce(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim name As String
102         name = Reader.ReadString8()

104         If LenB(name) = 0 Then Exit Sub

106         If EsGmChar(name) Then
108             Call WriteConsoleMsg(userindex, "No pod�s denunciar a un administrador.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            Dim tUser As Integer
110         tUser = NameIndex(name)
        
112         If tUser <= 0 Then
114             Call WriteConsoleMsg(userindex, "El usuario no est� online.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            Dim Denuncia As String, HayChat As Boolean
116         Denuncia = "[�ltimos mensajes de " & UserList(tUser).name & "]" & vbNewLine
        
            Dim i As Integer

118         For i = 1 To UBound(UserList(tUser).flags.ChatHistory)

120             If LenB(UserList(tUser).flags.ChatHistory(i)) <> 0 Then
122                 Denuncia = Denuncia & UserList(tUser).flags.ChatHistory(i) & vbNewLine
124                 HayChat = True

                End If

            Next
        
126         If Not HayChat Then
128             Call WriteConsoleMsg(userindex, "El usuario no ha escrito nada. Record� que las denuncias inv�lidas pueden ser motivo de advertencia.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

136         Call Ayuda.Push(.name, Denuncia, "Denuncia a " & UserList(tUser).name)
138         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Se ha recibido una nueva denuncia de parte de " & .name & ".", e_FontTypeNames.FONTTYPE_SERVER))

140         Call WriteConsoleMsg(userindex, "Tu denuncia fue recibida por el equipo de soporte.", e_FontTypeNames.FONTTYPE_INFOIAO)

142         Call LogConsulta(.name & " (Denuncia a " & UserList(tUser).name & ")" & vbNewLine & Denuncia)

        End With
    
        Exit Sub
    
        Exit Sub

ErrHandler:
144     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDenounce", Erl)
146

End Sub

Private Sub HandleSeguroResu(ByVal userindex As Integer)

100     With UserList(userindex)

102         .flags.SeguroResu = Not .flags.SeguroResu
        
104         Call WriteSeguroResu(userindex, .flags.SeguroResu)
    
        End With

End Sub

Private Sub HandleCuentaExtractItem(ByVal userindex As Integer)
        
        On Error GoTo HandleCuentaExtractItem_Err

        '***************************************************
        'Author: Ladder
        'Last Modification: 22/11/21
        'Retirar item de cuenta
        '***************************************************

100     With UserList(userindex)

            Dim Slot        As Byte

            Dim slotdestino As Byte

            Dim amount      As Integer
        
102         Slot = Reader.ReadInt()
104         amount = Reader.ReadInt()
        
106         slotdestino = Reader.ReadInt()
        
108         If .flags.Muerto = 1 Then
110             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
112         If .flags.TargetNPC < 1 Then Exit Sub
        
114         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Banquero Then
                Exit Sub

            End If
        
            'ac� va el guardado en memoria
        
            'User retira el item del slot
            'Call UserRetiraItem(UserIndex, slot, Amount, slotdestino)

        End With
        
        Exit Sub

HandleCuentaExtractItem_Err:
116     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCuentaExtractItem", Erl)
118
        
End Sub

Private Sub HandleCuentaDeposit(ByVal userindex As Integer)
        
        On Error GoTo HandleCuentaDeposit_Err

        '***************************************************
        'Author: Ladder
        'Last Modification: 22/11/21
        'Depositar item en cuenta
        '***************************************************
    
100     With UserList(userindex)

            Dim Slot        As Byte

            Dim slotdestino As Byte

            Dim amount      As Integer
        
102         Slot = Reader.ReadInt()
104         amount = Reader.ReadInt()
106         slotdestino = Reader.ReadInt()
        
            'Dead people can't commerce...
108         If .flags.Muerto = 1 Then
110             Call WriteConsoleMsg(userindex, "��Est�s muerto!!", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            '�El target es un NPC valido?
112         If .flags.TargetNPC < 1 Then Exit Sub
        
            '�El NPC puede comerciar?
114         If NpcList(.flags.TargetNPC).NPCtype <> e_NPCType.Banquero Then
                Exit Sub

            End If
            
116         If Distancia(NpcList(.flags.TargetNPC).Pos, .Pos) > 10 Then
118             Call WriteLocaleMsg(userindex, "8", e_FontTypeNames.FONTTYPE_INFO)
                'Call WriteConsoleMsg(UserIndex, "Est�s demasiado lejos.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If
        
            'ac� va el guardado en memoria
            
            'User deposita el item del slot rdata
            'Call UserDepositaItem(UserIndex, slot, Amount, slotdestino)

        End With
        
        Exit Sub

HandleCuentaDeposit_Err:
120     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCuentaDeposit", Erl)
122
        
End Sub

Private Sub HandleCommerceSendChatMessage(ByVal userindex As Integer)

        On Error GoTo ErrHandler
    
100     With UserList(userindex)

            Dim chatMessage As String
        
102         chatMessage = "[" & UserList(userindex).name & "] " & Reader.ReadString8
        
            'El mensaje se lo env�o al destino
            If UserList(userindex).ComUsu.DestUsu <= 0 Then Exit Sub
104         Call WriteCommerceRecieveChatMessage(UserList(userindex).ComUsu.DestUsu, chatMessage)
        
            'y tambien a mi mismo
106         Call WriteCommerceRecieveChatMessage(userindex, chatMessage)

        End With
    
        Exit Sub
    
ErrHandler:
108     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCommerceSendChatMessage", Erl)
110
    
End Sub

Private Sub HandleLogMacroClickHechizo(ByVal userindex As Integer)

100     With UserList(userindex)
            Dim tipoMacro As Byte
            Dim Mensaje As String
            Dim clicks As Long
            tipoMacro = Reader.ReadInt
            clicks = Reader.ReadInt
            
            Select Case tipoMacro
            
                Case tMacro.Coordenadas
102                 Mensaje = "AntiCheat> El usuario " & UserList(userindex).name & " est� utilizando macro de COORDENADAS."
                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(Mensaje, e_FontTypeNames.FONTTYPE_INFO))
                Case tMacro.dobleclick
                    Mensaje = "AntiCheat> El usuario " & UserList(userindex).name & " est� utilizando macro de DOBLE CLICK (CANTIDAD DE CLICKS: " & clicks & " )."
                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(Mensaje, e_FontTypeNames.FONTTYPE_INFO))
                Case tMacro.inasistidoPosFija
                    Mensaje = "AntiCheat> El usuario " & UserList(userindex).name & " est� utilizando macro de INASISTIDO."
                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(Mensaje, e_FontTypeNames.FONTTYPE_INFO))
            End Select
            
            

        End With

End Sub

Private Sub HandleCreateEvent(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     With UserList(userindex)

            Dim name As String
102         name = Reader.ReadString8()

104         If LenB(name) = 0 Then Exit Sub
    
106         If (.flags.Privilegios And (e_PlayerType.Admin Or e_PlayerType.Dios)) = 0 Then
108             Call WriteConsoleMsg(userindex, "Servidor � Comando deshabilitado para tu cargo.", e_FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
    
110         Select Case UCase$(name)

                Case "INVASION BANDER"
112                 Call IniciarEvento(TipoEvento.Invasion, 1)
114                 Call LogGM(.name, "Forz� el evento Invasi�n en Banderbille.")
                
116             Case "INVASION CARCEL"
118                 Call IniciarEvento(TipoEvento.Invasion, 2)
120                 Call LogGM(.name, "Forz� el evento Invasi�n en Carcel.")

122             Case Else
124                 Call WriteConsoleMsg(userindex, "No existe el evento """ & name & """.", e_FontTypeNames.FONTTYPE_INFO)

            End Select

        End With
    
        Exit Sub

ErrHandler:
126     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCreateEvent", Erl)
128
        
End Sub

Private Sub HandleHome(ByVal userindex As Integer)
        
        On Error GoTo HandleHome_Err
    
        

        '***************************************************
        'Author: Budi
        'Creation Date: 06/01/2010
        'Last Modification: 05/06/10
        'Pato - 05/06/10: Add the UCase$ to prevent problems.
        '***************************************************
    
100     With UserList(userindex)

104         If .flags.Muerto = 0 Then
106             Call WriteConsoleMsg(userindex, "Debes estar muerto para utilizar este comando.", e_FontTypeNames.FONTTYPE_FIGHT)
                Exit Sub

            End If
                
            'Si el mapa tiene alguna restriccion (newbie, dungeon, etc...), no lo dejamos viajar.
108         If MapInfo(.Pos.Map).zone = "NEWBIE" Or MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = CARCEL Then
110             Call WriteConsoleMsg(userindex, "No pueder viajar a tu hogar desde este mapa.", e_FontTypeNames.FONTTYPE_FIGHT)
                Exit Sub
            
            End If
        
            'Si es un mapa comun y no esta en cana
112         If .Counters.Pena <> 0 Then
114             Call WriteConsoleMsg(userindex, "No puedes usar este comando en prisi�n.", e_FontTypeNames.FONTTYPE_FIGHT)
                Exit Sub

            End If
            
116         If .flags.EnReto Then
118             Call WriteConsoleMsg(userindex, "No pod�s regresar desde un reto. Usa /ABANDONAR para admitir la derrota y volver a la ciudad.", e_FontTypeNames.FONTTYPE_FIGHT)
                Exit Sub
            End If

120         If .flags.Traveling = 0 Then
            
122             If .Pos.Map <> Ciudades(.Hogar).Map Then
124                 Call goHome(userindex)
                
                Else
126                 Call WriteConsoleMsg(userindex, "Ya te encuentras en tu hogar.", e_FontTypeNames.FONTTYPE_INFO)

                End If

            Else

128             .flags.Traveling = 0
130             .Counters.goHome = 0
            
132             Call WriteConsoleMsg(userindex, "Ya hay un viaje en curso.", e_FontTypeNames.FONTTYPE_INFO)
            
            End If
        
        End With

        
        Exit Sub

HandleHome_Err:
134     Call TraceError(Err.Number, Err.Description, "Hogar.HandleHome", Erl)

        
End Sub

Private Sub HandleAddItemCrafting(ByVal userindex As Integer)

        On Error GoTo ErrHandler
    
100     With UserList(userindex)
    
            Dim InvSlot As Byte, CraftSlot As Byte
102         InvSlot = Reader.ReadInt
104         CraftSlot = Reader.ReadInt
        
106         If .flags.Crafteando = 0 Then Exit Sub
        
108         If InvSlot < 1 Or InvSlot > .CurrentInventorySlots Then Exit Sub

110         If .Invent.Object(InvSlot).ObjIndex = 0 Then Exit Sub

112         If CraftSlot < 1 Then
114             For CraftSlot = 1 To MAX_SLOTS_CRAFTEO
116                 If .CraftInventory(CraftSlot) = 0 Then
                        Exit For
                    End If
                Next
            End If

118         If CraftSlot > MAX_SLOTS_CRAFTEO Then
                Exit Sub
            End If

120         If .CraftInventory(CraftSlot) <> 0 Then Exit Sub

122         .CraftInventory(CraftSlot) = .Invent.Object(InvSlot).ObjIndex
    
124         Call QuitarUserInvItem(userindex, InvSlot, 1)
126         Call UpdateUserInv(False, userindex, InvSlot)

128         Call WriteCraftingItem(userindex, CraftSlot, .CraftInventory(CraftSlot))

            Dim result As clsCrafteo
130         Set result = CheckCraftingResult(userindex)
        
132         If Not result Is .CraftResult Then
134             Set .CraftResult = result
136             If Not .CraftResult Is Nothing Then
138                 Call WriteCraftingResult(userindex, .CraftResult.Resultado, CalculateCraftProb(userindex, .CraftResult.Probabilidad), .CraftResult.Precio)
                Else
140                 Call WriteCraftingResult(userindex, 0)
                End If
            End If

        End With
    
        Exit Sub

ErrHandler:
142     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAddItemCrafting", Erl)
144
End Sub

Private Sub HandleRemoveItemCrafting(ByVal userindex As Integer)
    
        On Error GoTo ErrHandler
    
100     With UserList(userindex)
    
            Dim InvSlot As Byte, CraftSlot As Byte
102         CraftSlot = Reader.ReadInt
104         InvSlot = Reader.ReadInt
        
106         If .flags.Crafteando = 0 Then Exit Sub

108         If CraftSlot < 1 Or CraftSlot > MAX_SLOTS_CRAFTEO Then Exit Sub

110         If .CraftInventory(CraftSlot) = 0 Then Exit Sub

112         If InvSlot < 1 Then
                Dim TmpObj As t_Obj
114             TmpObj.ObjIndex = .CraftInventory(CraftSlot)
116             TmpObj.amount = 1
             
118             If Not MeterItemEnInventario(userindex, TmpObj) Then Exit Sub

120         ElseIf InvSlot <= .CurrentInventorySlots Then
122             If .Invent.Object(InvSlot).ObjIndex = 0 Then
124                 .Invent.Object(InvSlot).ObjIndex = .CraftInventory(CraftSlot)
            
126             ElseIf .Invent.Object(InvSlot).ObjIndex <> .CraftInventory(CraftSlot) Then
                    Exit Sub
                End If

128             .Invent.Object(InvSlot).amount = .Invent.Object(InvSlot).amount + 1
130             Call UpdateUserInv(False, userindex, InvSlot)
            End If

132         .CraftInventory(CraftSlot) = 0
134         Call WriteCraftingItem(userindex, CraftSlot, 0)
        
            Dim result As clsCrafteo
136         Set result = CheckCraftingResult(userindex)
        
138         If Not result Is .CraftResult Then
140             Set .CraftResult = result
142             If Not .CraftResult Is Nothing Then
144                 Call WriteCraftingResult(userindex, .CraftResult.Resultado, CalculateCraftProb(userindex, .CraftResult.Probabilidad), .CraftResult.Precio)
                Else
146                 Call WriteCraftingResult(userindex, 0)
                End If
            End If

        End With
    
        Exit Sub
    
ErrHandler:
148     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRemoveItemCrafting", Erl)
150
End Sub

Private Sub HandleAddCatalyst(ByVal userindex As Integer)

        On Error GoTo ErrHandler
    
100     With UserList(userindex)
    
            Dim Slot As Byte
102         Slot = Reader.ReadInt
        
104         If .flags.Crafteando = 0 Then Exit Sub
        
106         If Slot < 1 Or Slot > .CurrentInventorySlots Then Exit Sub

108         If .Invent.Object(Slot).ObjIndex = 0 Then Exit Sub
        
110         If ObjData(.Invent.Object(Slot).ObjIndex).CatalizadorTipo = 0 Then Exit Sub

112         If .CraftCatalyst.ObjIndex <> 0 Then Exit Sub

114         .CraftCatalyst.ObjIndex = .Invent.Object(Slot).ObjIndex
116         .CraftCatalyst.amount = .Invent.Object(Slot).amount

118         Call QuitarUserInvItem(userindex, Slot, MAX_INVENTORY_OBJS)
120         Call UpdateUserInv(False, userindex, Slot)

122         If .CraftResult Is Nothing Then
124             Call WriteCraftingCatalyst(userindex, .CraftCatalyst.ObjIndex, .CraftCatalyst.amount, 0)
            Else
126             Call WriteCraftingCatalyst(userindex, .CraftCatalyst.ObjIndex, .CraftCatalyst.amount, CalculateCraftProb(userindex, .CraftResult.Probabilidad))
            End If

        End With
    
        Exit Sub
    
ErrHandler:
128     Call TraceError(Err.Number, Err.Description, "Protocol.HandleAddCatalyst", Erl)
130
End Sub

Private Sub HandleRemoveCatalyst(ByVal userindex As Integer)

        On Error GoTo ErrHandler
    
100     With UserList(userindex)
    
            Dim Slot As Byte
102         Slot = Reader.ReadInt
        
104         If .flags.Crafteando = 0 Then Exit Sub

106         If .CraftCatalyst.ObjIndex = 0 Then Exit Sub

108         If Slot < 1 Then
110             If Not MeterItemEnInventario(userindex, .CraftCatalyst) Then Exit Sub

112         ElseIf Slot <= .CurrentInventorySlots Then
114             If .Invent.Object(Slot).ObjIndex = 0 Then
116                 .Invent.Object(Slot).ObjIndex = .CraftCatalyst.ObjIndex

118             ElseIf .Invent.Object(Slot).ObjIndex <> .CraftCatalyst.ObjIndex Then
                    Exit Sub
                End If

120             .Invent.Object(Slot).amount = .Invent.Object(Slot).amount + .CraftCatalyst.amount
122             Call UpdateUserInv(False, userindex, Slot)
            End If

124         .CraftCatalyst.ObjIndex = 0
126         .CraftCatalyst.amount = 0
        
128         If .CraftResult Is Nothing Then
130             Call WriteCraftingCatalyst(userindex, 0, 0, 0)
            Else
132             Call WriteCraftingCatalyst(userindex, 0, 0, CalculateCraftProb(userindex, .CraftResult.Probabilidad))
            End If

        End With
    
        Exit Sub
    
ErrHandler:
134     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRemoveCatalyst", Erl)
136
End Sub

Sub HandleCraftItem(ByVal userindex As Integer)

        On Error GoTo ErrHandler

100     If UserList(userindex).flags.Crafteando = 0 Then Exit Sub

102     Call DoCraftItem(userindex)
    
        Exit Sub

ErrHandler:
104     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCraftItem", Erl)
106
End Sub

Private Sub HandleCloseCrafting(ByVal userindex As Integer)

        On Error GoTo ErrHandler
    
100     If UserList(userindex).flags.Crafteando = 0 Then Exit Sub

102     Call ReturnCraftingItems(userindex)
    
104     UserList(userindex).flags.Crafteando = 0
    
        Exit Sub
    
ErrHandler:
106     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCloseCrafting", Erl)
108
End Sub

Private Sub HandleMoveCraftItem(ByVal userindex As Integer)

        On Error GoTo ErrHandler
    
100     With UserList(userindex)
    
            Dim Drag As Byte, Drop As Byte
102         Drag = Reader.ReadInt
104         Drop = Reader.ReadInt
        
106         If .flags.Crafteando = 0 Then Exit Sub
        
108         If Drag < 1 Or Drag > MAX_SLOTS_CRAFTEO Then Exit Sub
110         If Drop < 1 Or Drop > MAX_SLOTS_CRAFTEO Then Exit Sub
112         If Drag = Drop Then Exit Sub

114         If .CraftInventory(Drag) = 0 Then Exit Sub
116         If .CraftInventory(Drag) = .CraftInventory(Drop) Then Exit Sub

            Dim aux As Integer
118         aux = .CraftInventory(Drop)
120         .CraftInventory(Drop) = .CraftInventory(Drag)
122         .CraftInventory(Drag) = aux

124         Call WriteCraftingItem(userindex, Drag, .CraftInventory(Drag))
126         Call WriteCraftingItem(userindex, Drop, .CraftInventory(Drop))

        End With
    
        Exit Sub
    
ErrHandler:
128     Call TraceError(Err.Number, Err.Description, "Protocol.HandleMoveCraftItem", Erl)
130
End Sub

Private Sub HandlePetLeaveAll(ByVal userindex As Integer)

        On Error GoTo ErrHandler
    
100     With UserList(userindex)
    
            Dim AlmenosUna As Boolean, i As Integer
    
102         For i = 1 To MAXMASCOTAS
104             If .MascotasIndex(i) > 0 Then
106                 If NpcList(.MascotasIndex(i)).flags.NPCActive Then
108                     Call QuitarNPC(.MascotasIndex(i))
110                     AlmenosUna = True
                    End If
                End If
112         Next i
        
114         If AlmenosUna Then
                .flags.ModificoMascotas = True
116             Call WriteConsoleMsg(userindex, "Liberaste a tus mascotas.", e_FontTypeNames.FONTTYPE_INFO)
            End If

        End With
    
        Exit Sub
    
ErrHandler:
118     Call TraceError(Err.Number, Err.Description, "Protocol.HandlePetLeaveAll", Erl)
120
End Sub


Private Sub HandleResetChar(ByVal userindex As Integer)
        On Error GoTo HandleResetChar_Err:
        
100     Dim Nick As String: Nick = Reader.ReadString8()

        #If DEBUGGING = 1 Then

            If UserList(userindex).flags.Privilegios And e_PlayerType.Admin Then
                Dim Index As Integer
                Index = NameIndex(Nick)
                
                If Index <= 0 Then
                    Call WriteConsoleMsg(userindex, "Usuario offline o inexistente.", e_FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If
                
                With UserList(Index)
                    .Stats.ELV = 1
                    .Stats.Exp = 0
                    .Stats.SkillPts = 10
                    
                    Dim i As Integer
                    For i = 1 To NUMSKILLS
                        .Stats.UserSkills(i) = 0
                    Next

                    .Stats.MaxHp = .Stats.UserAtributos(e_Atributos.Constitucion)
                    .Stats.MinHp = .Stats.MaxHp

                    .Stats.MaxMAN = .Stats.UserAtributos(e_Atributos.Inteligencia) * ModClase(.clase).ManaInicial
                    .Stats.MinMAN = .Stats.MaxMAN

                    Dim MiInt As Integer
                    MiInt = RandomNumber(1, .Stats.UserAtributosBackUP(e_Atributos.Agilidad) \ 6)

                    If MiInt = 1 Then MiInt = 2
                
                    .Stats.MaxSta = 20 * MiInt
                    .Stats.MinSta = 20 * MiInt
                
                    .Stats.MaxAGU = 100
                    .Stats.MinAGU = 100
                
                    .Stats.MaxHam = 100
                    .Stats.MinHam = 100
            
                    .Stats.MaxHit = 2
                    .Stats.MinHIT = 1
                    
                    .flags.ModificoSkills = True
                    
                    Call WriteUpdateUserStats(Index)
                    Call WriteLevelUp(Index, .Stats.SkillPts)
                End With
                
                Call WriteConsoleMsg(userindex, "Personaje reseteado a nivel 1.", e_FontTypeNames.FONTTYPE_INFO)
            End If
        
        #End If
        
        Exit Sub

HandleResetChar_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleResetChar", Erl)
End Sub
Private Sub HandleResetearPersonaje(ByVal userindex As Integer)
    On Error GoTo HandleResetearPersonaje_Err:

   ' Call resetPj(UserIndex)

    Exit Sub

HandleResetearPersonaje_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleResetearPersonaje", Erl)
End Sub

Private Sub HandleRomperCania(ByVal userindex As Integer)

    On Error GoTo HandleRomperCania_Err:
    
    Dim LoopC As Integer
    Dim obj As t_Obj
    Dim caniaOld As Integer
    With UserList(userindex)
    
    obj.ObjIndex = .Invent.HerramientaEqpObjIndex
    caniaOld = .Invent.HerramientaEqpObjIndex
    obj.amount = 1
    For LoopC = 1 To MAX_INVENTORY_SLOTS
            
        'Rastreo la ca�a que est� usando en el inventario y se la rompo
        If .Invent.Object(LoopC).ObjIndex = .Invent.HerramientaEqpObjIndex Then
            'Le quito una ca�a
            Call QuitarUserInvItem(userindex, LoopC, 1)
            Call UpdateUserInv(False, userindex, LoopC)
            Select Case caniaOld
                Case 881
                    obj.ObjIndex = 3457
                Case 2121
                    obj.ObjIndex = 3456
                Case 2132
                    obj.ObjIndex = 3459
                Case 2133
                    obj.ObjIndex = 3458
            End Select
            
            Call MeterItemEnInventario(userindex, obj)
            
            
            Exit Sub
            
        End If

262 Next LoopC

    End With
    
     'UserList(UserIndex).Invent.HerramientaEqpObjIndex
    
HandleRomperCania_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRomperCania", Erl)
End Sub
Private Sub HandleFinalizarPescaEspecial(ByVal userindex As Integer)

    On Error GoTo HandleFinalizarPescaEspecial_Err:
    
    Call EntregarPezEspecial(userindex)
    
    Exit Sub

HandleFinalizarPescaEspecial_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleFinalizarPescaEspecial", Erl)
End Sub

Private Sub HandleRepeatMacro(ByVal userindex As Integer)

    On Error GoTo HandleRepeatMacro_Err:
    'Call LogMacroCliente("El usuario " & UserList(UserIndex).name & " iter� el paquete click o u." & GetTickCount)
    Exit Sub

HandleRepeatMacro_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleRepeatMacro", Erl)
End Sub

Private Sub HandleDeleteItem(ByVal userindex As Integer)
    On Error GoTo HandleDeleteItem_Err:

    Dim Slot As Byte

    Slot = Reader.ReadInt()

    With UserList(userindex)
        If Slot >= getMaxInventorySlots(userindex) Or Slot <= 0 Then Exit Sub
        
        If MapInfo(UserList(userindex).Pos.Map).Seguro = 0 Then
            Call WriteConsoleMsg(userindex, "Solo puedes eliminar items en zona segura.", e_FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
        
        If .Invent.Object(Slot).Equipped = 0 Then
            UserList(userindex).Invent.Object(Slot).amount = 0
            UserList(userindex).Invent.Object(Slot).Equipped = 0
            UserList(userindex).Invent.Object(Slot).ObjIndex = 0
            Call UpdateUserInv(False, userindex, Slot)
            Call WriteConsoleMsg(userindex, "Objeto eliminado correctamente.", e_FontTypeNames.FONTTYPE_INFO)
        Else
            Call WriteConsoleMsg(userindex, "No puedes eliminar un objeto estando equipado.", e_FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
    End With

    Exit Sub

HandleDeleteItem_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDeleteItem", Erl)
End Sub

Private Sub HandleCreateAccount(ByVal userindex As Integer)
    On Error GoTo HandleCreateAccount_Err:
    
    Dim UserName As String
    Dim Password As String
    UserName = Reader.ReadString8
    Password = Reader.ReadString8
    
    If (UserName = "" Or Password = "" Or LenB(Password) <= 3) Then
        Call WriteErrorMsg(userindex, "Parametros incorrectos")
        Call CloseSocket(userindex)
        Exit Sub
    End If

    Dim result As ADODB.Recordset
    Set result = Query("INSERT INTO account (email, password, salt, validate_code) VALUES (?, ?, ?, ?)", UserName, Password, "<Empty>", "<Empty>")

    If (result Is Nothing) Then
        Call WriteErrorMsg(userindex, "Ya hay una cuenta asociada con ese email")
        Call CloseSocket(userindex)
        Exit Sub
    End If
    
    Set result = Query("SELECT id FROM account WHERE email=?", UserName)
    UserList(userindex).AccountID = result!ID
    
    Dim Personajes() As t_PersonajeCuenta
    Call WriteAccountCharacterList(userindex, Personajes, 0)

    Exit Sub
HandleCreateAccount_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleCreateAccount", Erl)
End Sub

Private Sub HandleLoginAccount(ByVal userindex As Integer)
    On Error GoTo LoginAccount_Err:
    
    Dim UserName As String
    Dim Password As String
    UserName = Reader.ReadString8
    Password = Reader.ReadString8
        
    If (UserName = "" Or Password = "" Or LenB(Password) <= 3) Then
        Call WriteErrorMsg(userindex, "Parametros incorrectos")
        Call CloseSocket(userindex)
        Exit Sub
    End If

    Dim result As ADODB.Recordset
    Set result = Query("SELECT * FROM account WHERE email=? AND password=?", UserName, Password)
    
    If (result.EOF) Then
        Call WriteErrorMsg(userindex, "Usuario o Contrase�a erronea.")
        Call CloseSocket(userindex)
        Exit Sub
    End If
        
    UserList(userindex).AccountID = result!ID
    
    Dim Personajes(8) As t_PersonajeCuenta
    Dim Count As Long
    Count = GetPersonajesCuentaDatabase(result!ID, Personajes)
    
    Call WriteAccountCharacterList(userindex, Personajes, Count)

    Exit Sub
LoginAccount_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleLoginAccount", Erl)
End Sub

Private Sub HandleDeleteCharacter(ByVal userindex As Integer)
    On Error GoTo DeleteCharacter_Err:

DeleteCharacter_Err:
102     Call TraceError(Err.Number, Err.Description, "Protocol.HandleDeleteCharacter", Erl)
End Sub
