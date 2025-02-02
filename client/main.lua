TattooShopMenu = RageUI.CreateMenu("Salon de tatouage", "Interactions disponibles")
TattooMenu = RageUI.CreateSubMenu(TattooShopMenu, "Salon de tatouage", "Interactions disponibles")
TattooMenu:AddInstructionButton({"~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~", "Tourner votre personnage à droite"})
TattooMenu:AddInstructionButton({"~INPUT_VEH_FLY_ROLL_LEFT_ONLY~", "Tourner votre personnage à gauche"})

TattooShopMenu.Closed = function()
    RegisterTattoo = {}
    ClearPedDecorations(PlayerPedId())
    Wait(180)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(Cam, false)
    LoadTattoo()
    SetOutfit(2)
    RageUI.Visible(TattooShopMenu, false)
    RageUI.Visible(TattooMenu, false)
    menuIsOpen = false
    FreezeEntityPosition(PlayerPedId(), false)
end
TattooMenu.onIndexChange = function(Index)
    ClearPedDecorations(PlayerPedId())
    SetPedDecoration(PlayerPedId(), TattooList[Index].lib, TattooList[Index].nameHash)
    for k,v in pairs(RegisterTattoo) do
        SetPedDecoration(PlayerPedId(), v.lib, v.texture)
    end
    CurrentLib = TattooList[Index].lib
    CurrentNameHash = TattooList[Index].nameHash
end 

function OpenTattooShopMenu()
    if menuIsOpen then 
        menuIsOpen = false 
        RageUI.Visible(TattooShopMenu,false)
        return
    else
        menuIsOpen = true 
        RageUI.Visible(TattooShopMenu, true)
        SetOutfit(1)
        CreateThread(function ()
            while menuIsOpen do
                turnPlayer()
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(TattooShopMenu, function()
                    RageUI.Separator("Prix d'un tatouage : ~g~"..TattooSettings.TattooPrice.."$")
                    RageUI.Button("Tatouages", false, {RightLabel = "→"}, true, {}, TattooMenu)
                    RageUI.Button(("Supprimer les tatouages ~g~%i$"):format(TattooSettings.DeleteTattooPrice), false, {RightBadge = RageUI.BadgeStyle.Alert}, true, {
                        onSelected = function()
                            TriggerServerEvent("tattoo:deleteTattoo")
                            TattooShopMenu.Closed()
                        end
                    })
                end)
                RageUI.IsVisible(TattooMenu, function()
                    for k,v in pairs(TattooList) do
                        RageUI.Button("Tatouage n° "..k, false, {}, true, {
                            onSelected = function()
                                table.insert(RegisterTattoo, {lib = CurrentLib, texture = CurrentNameHash})
                                TriggerServerEvent("tattoo:registerTattoo", RegisterTattoo)
                                Wait(150)
                                TattooShopMenu.Closed()
                            end
                        })
                    end
                end)
                Wait(0)
            end
        end)
    end
end

TattooList = {
    {nameHash = 'MP_Buis_M_Neck_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_Neck_001', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_Neck_002', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_Neck_003', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_LeftArm_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_LeftArm_001', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_RightArm_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_RightArm_001', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_Stomach_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_Chest_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_Chest_001', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_M_Back_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Chest_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Chest_001', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Chest_002', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Stom_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Stom_001', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Stom_002', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Back_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Back_001', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Neck_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_Neck_001', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_RArm_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_LArm_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_LLeg_000', lib = "mpbusiness_overlays"},
    {nameHash = 'MP_Buis_F_RLeg_000', lib = "mpbusiness_overlays"},
    {nameHash = 'FM_Hip_M_Tat_000', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_001', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_002', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_003', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_004', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_005', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_006', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_007', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_008', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_009', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_010', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_011', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_012', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_013', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_014', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_015', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_016', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_017', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_018', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_019', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_020', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_021', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_022', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_023', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_024', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_025', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_026', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_027', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_028', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_029', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_030', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_031', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_032', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_033', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_034', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_035', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_036', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_037', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_038', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_039', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_040', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_041', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_042', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_043', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_044', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_045', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_046', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_047', lib = "mphipster_overlays"},
    {nameHash = 'FM_Hip_M_Tat_048', lib = "mphipster_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_000_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_001_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_002_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_003_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_004_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_005_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_006_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_007_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_008_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_009_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_010_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_011_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_012_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_013_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_014_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_015_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_016_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_017_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_018_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_019_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_020_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_021_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_022_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_023_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_024_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_025_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_026_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_027_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_028_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_029_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_030_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_031_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_032_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_033_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_034_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_035_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_036_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_037_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_038_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_039_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_040_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_041_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_042_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_043_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_044_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_045_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_046_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_047_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_048_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_049_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_050_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_051_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_052_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_053_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_054_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_055_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_056_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_057_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_058_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_059_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_MP_Biker_Tat_060_M', lib = "mpbiker_overlays"},
    {nameHash = 'MP_Airraces_Tattoo_000_M', lib = "mpairraces_overlays"},
    {nameHash = 'MP_Airraces_Tattoo_001_M', lib = "mpairraces_overlays"},
    {nameHash = 'MP_Airraces_Tattoo_002_M', lib = "mpairraces_overlays"},
    {nameHash = 'MP_Airraces_Tattoo_003_M',  lib = "mpairraces_overlays"},
    {nameHash = 'MP_Airraces_Tattoo_004_M', lib = "mpairraces_overlays"},
    {nameHash = 'MP_Airraces_Tattoo_005_M', lib = "mpairraces_overlays"},
    {nameHash = 'MP_Airraces_Tattoo_006_M', lib = "mpairraces_overlays"},
    {nameHash = 'MP_Airraces_Tattoo_007_M', lib = "mpairraces_overlays"},
    {nameHash = 'MP_Bea_M_Back_000', lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Chest_000',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Chest_001',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Head_000',   lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Head_001',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Head_002',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Lleg_000',   lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Rleg_000',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_RArm_000',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Head_000',   lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_LArm_000',   lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_LArm_001',   lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Neck_000',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Neck_001',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_RArm_001',  lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Stom_000',   lib = "mpbeach_overlays"},
    {nameHash = 'MP_Bea_M_Stom_001', lib = "mpbeach_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_000',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_001',   lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_003',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_004',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_005', lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_006', lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_007',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_008',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_009',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_010',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_011', lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_012',   lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_013',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_014',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_015', lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_016',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_017',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_018',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_019',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_022',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_023',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_024',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_025',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_026',   lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_027',   lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_028',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Xmas2_M_Tat_029',  lib = "mpchristmas2_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_000_M', lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_001_M', lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_002_M',   lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_003_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_004_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_005_M',   lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_006_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_007_M',   lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_008_M',   lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_009_M', lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_010_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_011_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_012_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_013_M', lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_014_M', lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_015_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_016_M',   lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_017_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_018_M', lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_019_M', lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_020_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_021_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_022_M', lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_023_M',   lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_024_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_025_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_026_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_027_M',   lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_028_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_029_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_Gunrunning_Tattoo_030_M',  lib = "mpgunrunning_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_000_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_001_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_002_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_003_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_004_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_005_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_006_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_007_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_008_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_009_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_010_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_MP_ImportExport_Tat_011_M', lib = "mpimportexport_overlays"},
    {nameHash = 'MP_LR_Tat_000_M', lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_003_M', lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_006_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_008_M', lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_011_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_012_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_016_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_018_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_019_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_022_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_028_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_029_M',   lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_030_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_031_M', lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_032_M', lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_035_M',  lib = "mplowrider2_overlays"},
    {nameHash = 'MP_LR_Tat_001_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_002_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_004_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_005_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_007_M',   lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_009_M', lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_010_M', lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_013_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_014_M', lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_015_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_017_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_020_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_021_M', lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_023_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_026_M',  lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_027_M',   lib = "mplowrider_overlays"},
    {nameHash = 'MP_LR_Tat_033_M',  lib = "mplowrider_overlays"},
}