TattooSettings = {
    Positions = { -- Positions des salons de tatouage
        {pos = vector3(1321.47, -1653.23, 51.27)},
        {pos = vector3(-1155.52, -1426.47, 3.95)},
        {pos = vector3(324.04, 179.55, 102.58)},
        {pos = vector3(-3168.87, 1076.94, 19.82)},
        {pos = vector3(1864.6, 3747.7, 32.06)},
        {pos = vector3(-294.10, 6199.70, 30.48)}
    },
    OutfitTatoo = { 
        male = { -- Tenue pour les hommes lors de la prévisualisation des tatouages
            ['tshirt_1'] = -1,  ['tshirt_2'] = 0,
            ['torso_1'] = 15,   ['torso_2'] = 0,
            ['arms'] = 15,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['glasses_1'] = -1,  ['glasses_2'] = 0,
            ['pants_1'] = 14,  ['pants_2'] = 0,
            ['shoes_1'] = 34,  ['shoes_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['chain_1'] = 0,  ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0
        },
        female = { -- Tenue pour les femmes lors de la prévisualisation des tatouages
            ['tshirt_1'] = -1,  ['tshirt_2'] = 0,
            ['torso_1'] = 15,   ['torso_2'] = 0,
            ['arms'] = 15,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['glasses_1'] = -1,  ['glasses_2'] = 0,
            ['pants_1'] = 15,  ['pants_2'] = 0,
            ['shoes_1'] = 35,  ['shoes_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['chain_1'] = 0,  ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0
        }
    },
    TattooPrice = 500, -- Prix d'un tatouage dans les salons de tatouage
    DeleteTattooPrice = 2000 -- Prix pour supprimer un tatouage dans les salons de tatouage
}