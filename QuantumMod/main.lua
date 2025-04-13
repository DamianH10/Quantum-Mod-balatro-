--- STEAMODDED HEADER
--- MOD_NAME: Quantum
--- MOD_ID: Quantum
--- MOD_AUTHOR: [Damian]
--- MOD_DESCRIPTION: Bringing Particle Phyisics to Balatro (very Unbalanced). "Goal" of the mod: Discover every card I guess?
--- PREFIX: quant
----------------------------------------------
------------MOD CODE -------------------------



--------------------------------------------
-------- Jokers ----------------------------
--------------------------------------------

SMODS.Atlas{
    key = 'MTO', --atlas key
    path = 'MTO.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

MTOlv = 0

SMODS.Joker{
    key = 'MTO', --joker key
    loc_txt = { -- local text
        name = 'Manipulate The Odds',
        text = {
          'Increases all odds by {C:green,X:MTOvl}#1#',
          'increases by 1 every 3 Hands played',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'MTO', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 77, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        MTOvl = 1 --configurable value
      }
    },

    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.MTOvl}} --#1# is replaced with card.ability.extra....
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            MTOlv = MTOlv + 1
            if MTOlv == 3 then
                for k, v in pairs(G.GAME.probabilities) do 
                    G.GAME.probabilities[k] = v/v
                    G.GAME.probabilities[k] = v+card.ability.extra.MTOvl
                end 
                card.ability.extra.MTOvl = card.ability.extra.MTOvl + 1
                MTOlv = 0
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
---------------------------------------------------------------------------------------
SMODS.Atlas{
    key = 'BL', --atlas key
    path = 'BadLuck.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

MTOlv = 0

SMODS.Joker{
    key = 'BL', --joker key
    loc_txt = { -- local text
        name = 'Bad Luck',
        text = {
          'Dencreases all odds by {C:green,X:MTOvl}#1#',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'BL', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        MTOvl = 1 --configurable value
      }
    },

    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.MTOvl}} --#1# is replaced with card.ability.extra....
    end,
    calculate = function(self,card,context)
        if context.joker_main then
                for k, v in pairs(G.GAME.probabilities) do 
                    G.GAME.probabilities[k] = v/v
                    G.GAME.probabilities[k] = v+card.ability.extra.MTOvl
                end 
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}

---------------------------------------------------------------------------------------
SMODS.Atlas{
    key = 'Bitcoin', -- atlas key
    path = 'Bitcoin.png',
    px = 71, -- width of one card
    py = 95  -- height of one card
}

SMODS.Joker{
    key = 'Bitcoin', -- joker key
    loc_txt = {
        name = 'Bitcoin',
        text = {
            'At the end of a Round,',
            '40% chance to add 1/4 of its value to itself,',
            '40% chance to deduct 1/4 of its value,',
            '15% chance nothing happens,',
            'and 5% chance to double its value!'
        },
    },
    atlas = 'Bitcoin',
    rarity = 2,
    cost = 20, 
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            value = 69  -- starting value
        }
    },
    
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra_value or self.config.extra.value } }
    end,

    calculate = function(self, card, context)
        if context and context.joker_main then
            -- Initialize ability if it's missing.
            if not card.ability then
                print("[Bitcoin] card.ability is nil, initializing it.")
                card.ability = {}
            end
            if card.ability.extra_value == nil then
                print("[Bitcoin] card.ability.extra_value is nil, setting default value.")
                card.ability.extra_value = self.config.extra.value or 0
            end

            local rng = math.random(100)  
            local currentValue = card.ability.extra_value
            local newValue = currentValue
            local message, colour

            if rng <= 40 then
                newValue = currentValue * 1.25
                message = "Value Increased"
                colour = G.C.MONEY
            elseif rng <= 80 then
                newValue = currentValue * 0.75
                message = "Value Decreased"
                colour = G.C.MONEY
            elseif rng <= 95 then
                newValue = currentValue 
                message = "No change"
                colour = G.C.MONEY
            else
                newValue = currentValue * 2
                message = "Doubled!!"
                colour = G.C.MONEY
            end

            card.ability.extra_value = newValue

            -- Directly update cost-related fields.
            local newSellCost = math.floor(newValue)
            card.cost = newSellCost
            card.sell_cost = newSellCost

            -- If set_cost() does other things, call it also.
            if card.set_cost then
                card:set_cost()
            end

            return {
                message = message,
                colour = colour
            }
        end
        return nil
    end,

    sell_cost = function(self, card)
        return math.floor(card.ability.extra_value or self.config.extra.value)
    end,

    in_pool = function(self, wawa, wawa2)
        return false --dosent work so its disabled for now
    end,
}
---------------------------------------------------------------------------------------
SMODS.Atlas{
    key = 'ETH', --atlas key
    path = 'ETH.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

MTOlv = 0

SMODS.Joker{
    key = 'ETH', --joker key
    loc_txt = { -- local text
        name = 'Etherium',
        text = {
          'has a chance to give between 15$ and -10$',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'ETH', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        MTOvl = 1 --configurable value
      }
    },

    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.MTOvl}} --#1# is replaced with card.ability.extra....
    end,
    calculate = function(self,card,context)
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
    calc_dollar_bonus = function(self,card)
        return math.random(15,-10)
    end
}

---------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'QuantumEntanglement', -- atlas key
    path = 'QuantumEntanglement.png', 
    px = 71, -- width of one card
    py = 95  -- height of one card
}

SMODS.Joker{
    key = 'QuantumEntanglement', -- joker key
    loc_txt = { -- local text
        name = 'Quantum Entanglement',
        text = {
            'Too long to explain!',
            'If the same numerical card exists in your hand,',
            'adds a bonus multiplier equal to the card value.'
        },
        --[[unlock = {
            'Discover the mysteries of entanglement',
        }]]
    },
    atlas = 'QuantumEntanglement', -- atlas key
    rarity = 2, -- rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 15, -- cost
    unlocked = true, -- unlocked or not
    discovered = false, -- whether it starts discovered
    blueprint_compat = true, -- blueprint/brainstormed/other compatibility
    eternal_compat = true, -- eternal compatible
    perishable_compat = false, -- perishable or not
    pos = { x = 0, y = 0 }, -- position in atlas (starting at 0, scales by atlas' card size)
    config = {
        extra = {
            mult = 0 -- initial configurable bonus multiplier (will update during play)
        }
    },
    
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult } } -- displays current bonus multiplier
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local played_value = card.value
            local duplicate_found = false
    
            if context.hand then
                for k, other in pairs(context.hand) do
                    print("[Quantum Entanglement] Comparing with card:", other.value)
                    if other ~= card and other.value == played_value then
                        duplicate_found = true
                        print("[Quantum Entanglement] Duplicate found for value:", played_value)
                        break
                    end
                end
            end
            if duplicate_found then
                local bonus = played_value
                card.ability.extra.mult = bonus
                print("[Quantum Entanglement] Bonus applied:", bonus)
                return {
                    card = card,
                    Xmult_mod = bonus,
                    message = '+' .. bonus,
                    colour = G.C.MULT
                }
            end
        end
        return nil
    end,
    
    

    in_pool = function(self, wawa, wawa2)
        return false --dosent work so its disabled for now
    end,
}

---------------------------------------------------------------------------------------
SMODS.Atlas{
    key = 'BlackHole', --atlas key
    path = 'BlackHole.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'BlackHole', --joker key
    loc_txt = { -- local text
        name = 'Black Hole',
        text = {
          'Sucks away {C:money}8${}',
          'at the end of a Round',
          'Gives {X:Xmult,C:white}X#1#{} Mult',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'BlackHole', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 10, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 10 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
    calc_dollar_bonus = function(self,card)
        return -8
    end
}

----------------------------------------------------------------------------------------------------
SMODS.Atlas{
    key = 'NeutronStar', --atlas key
    path = 'NeutronStar.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'NeutronStar', --joker key
    loc_txt = { -- local text
        name = 'Neutron Star',
        text = {
          'Really Really DENSE',
          'Multiplies your chips by 2',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'NeutronStar', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 100, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 69 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return{
                chips = G.GAME.current_round.current_hand.chips
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}

----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'DyingStar', --atlas key
    path = 'DyingStar.png',
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'DyingStar', --joker key
    loc_txt = { -- local text
        name = 'Dying Star',
        text = {
          'Dies in 10 Rounds',
          'Multiplies its Mult by 2',
          'Current Mult:{X:mult,C:white}#1#{}',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'DyingStar', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 40, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 40 --configurable value
      }
    },

    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            card.ability.extra.mult =  card.ability.extra.mult * 2
            return {
                card = card,
                mult = card.ability.extra.mult, -- Add to the multiplier
                colour = G.C.MULT
            }
        end
        if card.ability.extra.mult == 20480 then
            card.ability.extra.mult = 0
        end
        
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'SuperamssiveStar', --atlas key
    path = 'SupermassiveStar.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'SupermassiveStar', --joker key
    loc_txt = { -- local text
        name = 'Supermassive Star',
        text = {
          'Really Really Big',
          'Multiplies its Chip-Bonus by 1.5',
          'Current Chip-Bonus:{X:chips,C:white}X#1#{}',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'SupermassiveStar', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 150, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 20 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            self.ability.extra.chips = self.ability.extra.chips * 1.5
            return{
                chips = self.ability.extra.chips
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Star', --atlas key
    path = 'Star.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'Star', --joker key
    loc_txt = { -- local text
        name = 'Star',
        text = {
          'A Star, What did you expect?',
          'our star has a core temp. of 100 Million',
          'Degrees Celcius:{X:chips,C:white}+#1# Chips{}',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Star', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 100 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return{
                chips = 100
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}

----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'DownQuark', --atlas key
    path = 'DownQuark.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Down', --joker key
    loc_txt = { -- local text
        name = 'DownQuark',
        text = {
          'Has a Mass of 5Mev',
          '{X:mult,C:white}+#1#{} Mult',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'DownQuark', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 16, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 500 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.mult, -- Add to the multiplier
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end

}

----------------------------------------------------------------------------

SMODS.Atlas{
    key = 'UpQuark', --atlas key
    path = 'UpQuark.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Up', --joker key
    loc_txt = { -- local text
        name = 'UpQuark',
        text = {
          'Has a Mass of 2Mev',
          'Gives an extra 200 Chips',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'UpQuark', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 200 --configurable value
      }
    },
    calculate = function(self, card, context)
        function Card:get_chip_bonus()
            return 200
        end
    end,
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.a_chips}} 
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end

}

---------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Electron', --atlas key
    path = 'Electron.png',
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Electron', --joker key
    loc_txt = { -- local text
        name = 'Electron',
        text = {
          'Has a Mass of 0.51099895069 MeV/c2',
          'Gives a Flat X3 Mult for Free',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Electron', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 3 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.a_chips}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
---------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Strange', --atlas key
    path = 'StrangeQuark.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Strange', --joker key
    loc_txt = { -- local text
        name = 'Strange Quark',
        text = {
          'Has a Mass of 95 MeV',
          'Has a property Called strangeness (dont ask what that is)',
          'Retriggers ALL Cards, BUT destroys all Played Cards.',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Strange', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        extra = 1 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra}}                
    end,

    calculate = function(self,context)
        if self.edition == nil then
            return {
                card = card,
                repetitions = 1
            }  
        end    
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
---------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Muon', --atlas key
    path = 'Muon.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'Muon', --joker key
    loc_txt = { -- local text
        name = 'Muon',
        text = {
          'Has a Mass of 105.6 MeV/c2',
          'Gives a Flat X6 Mult for Free',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Muon', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 25, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 6 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
-------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Tau', --atlas key
    path = 'Tau.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Tau', --joker key
    loc_txt = { -- local text
        name = 'Tau',
        text = {
          'Has a Mass of 1776.8 MeV/c2',
          'Gives a Flat X10 Mult for Free',
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Tau', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 100, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 10 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
---------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Charm', --atlas key
    path = 'Charm.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Charm', --joker key
    loc_txt = { -- local text
        name = 'Charm',
        text = {
          'Has a Mass of 1.2 GeV/c2',
          'Every Round this Card Gets a prmanent Boost,',
          'of {X:mult,C:white}+#1#{} Mult'
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Charm', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 30, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 25 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            card.ability.extra.mult = card.ability.extra.mult + 25
            return {
                card = card,
                mult = card.ability.extra.mult, -- Add to the multiplier
                colour = G.C.MULT
            }
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
--------------------------------------------------------------------

SMODS.Atlas{
    key = 'Bottom', --atlas key
    path = 'Bottom.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Bottom Quark', --joker key
    loc_txt = { -- local text
        name = 'Bottom',
        text = {
          'Has a Mass of 4.3 GeV/c2',
          'Pretty Simple, Just Gives a ',
          'of {X:Xmult,C:white}X#1#{} Mult'
          
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Bottom', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 75, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 25 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
            
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
-------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Top', --atlas key
    path = 'Top.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Top', --joker key
    loc_txt = { -- local text
        name = 'Top Quark',
        text = {
          'Has a Mass of 173 GeV/c2!!',
          'Every Round this Card Gets a prmanent Boost,',
          'of {X:Xmult,C:white}X#1#{} Mult'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Top', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 100, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 5 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            card.ability.extra.Xmult = card.ability.extra.Xmult + 5
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
---------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Penta', --atlas key
    path = 'Penta.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Penta', --joker key
    loc_txt = { -- local text
        name = 'PentaQuark',
        text = {
          'The Myth The Legend THE ONLY',
          'PENTAQUARK! The first Man-Made,',
          'Subatomic Particle. Doubles Its Mult',
          'EVERY ROUND. Current Mult:',
          '{X:Xmult,C:white}X#1#{}}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Penta', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 200, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 2 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            card.ability.extra.Xmult = card.ability.extra.Xmult * 2
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'StrongF', --atlas key
    path = 'StrongF.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'StrongF', --joker key
    loc_txt = { -- local text
        name = 'Strong Force',
        text = {
          'The Strong Force',
          'Able To  Bind Together Quarks,',
          'To Form Hadrons and nuclei,',
          'Creates 1 Subatomic Particle',
          'EACH ROUND.'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'StrongF', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 50, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 2 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            local card = create_card('Particle',G.consumeables)
            card:add_to_deck()
            G.consumeables:emplace(card)
            G.GAME.consumeable_buffer = 0
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Gravity', --atlas key
    path = 'Gravity.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Gravity', --joker key
    loc_txt = { -- local text
        name = 'Gravity',
        text = {
          'The Gravitational Force',
          'Makes Mass Come Together,',
          'HOW TF AM I SUPPOSED TO MAKE,',
          'AN ABILITY FOR F*ing GRAVITY',
          'IN FACT GRVITY IS HARD TO DESCRIBE',
          'ON QUANTUM LEVES, THERES A WHOLE',
          'THEORY ABOUT IT! QUANTUM-GRAVITY!',
          'anyway, gives 10$ at the end of a round',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Gravity', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 50, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 2 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,

    calculate = function(self,card,context)
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

    calc_dollar_bonus = function(self,card)
        return 10
    end

}

----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Higgs', --atlas key
    path = 'Higgs.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Higgs', --joker key
    loc_txt = { -- local text
        name = 'Higgs Boson',
        text = {
          'The Myth The Legend THE G O D',
          'HIGGS! The GOD Particle,',
          'Multiplies Its Mult By its Mult,',
          'EVERY ROUND. Current Mult:',
          '{X:Xmult,C:white}X#1#{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Higgs', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 125, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 2 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            card.ability.extra.Xmult = card.ability.extra.Xmult * card.ability.extra.Xmult
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

}
----------------------------------------------------------------------------------------------------
SMODS.Atlas{
    key = 'ElectroM', --atlas key
    path = 'ElectroM.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'ElectroM', --joker key
    loc_txt = { -- local text
        name = 'Electro-Magnetism',
        text = {
          'The Electromagnetic Force',
          'Pushes away Two Particles with same charge,',
          'If a Played Card (Negativley Charged Card) is',
          'Next To Another Negativley Charged Card gives',
          '{X:chips,C:white}+#1#{} (Fine constant num) Chips.'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'ElectroM', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 50, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 1370 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                chips = 1370,
            }
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,


}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Weak', --atlas key
    path = 'Weak.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Weak', --joker key
    loc_txt = { -- local text
        name = 'Weak-Force',
        text = {
          'The Weak (Nuclear) Force',
          'is able to change Matter in a,',
          'Fundamental way. Requires',
          '5$ Upkeep to create a random',
          'Rare Joker every round.'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Weak', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 100, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 1 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            local card_killed = false
            local card = create_card('Joker', G.jokers, nil, 0.99, nil, nil, nil, 'wra')
            card:add_to_deck()
            G.jokers:emplace(card)
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,

    calc_dollar_bonus = function(self,card)
        return -5
    end

}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'ZBoson', --atlas key
    path = 'ZBoson.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'ZBoson', --joker key
    loc_txt = { -- local text
        name = 'Z Boson',
        text = {
          'The first Mediator',
          'of the Weak Force.',
          'Mass: 91GeV!!!!!',
          'converts mult into chips',
          '-25 Mult +250 chips'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'ZBoson', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 90, --cost
    
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = -25 --configurable value
      }
    },

    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                chips = 250
            }
        end
        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.mult, -- Add to the multiplier
                colour = G.C.MULT
            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'WBoson', --atlas key
    path = 'WBoson.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'WBoson', --joker key
    loc_txt = { -- local text
        name = 'W- Boson',
        text = {
          'The second Mediator',
          'of the Weak Force.',
          'Mass: 80 GeV!!!!',
          'converts money into mult',
          '{X:mult ,C:white}+#1#{} -{C:money}10${}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'WBoson', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 90, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 100 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.mult, -- Add to the multiplier
                colour = G.C.MULT
            }
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
    calc_dollar_bonus = function(self,card)
        return -10
    end
}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'W+Boson', --atlas key
    path = 'W+Boson.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'W+Boson', --joker key
    loc_txt = { -- local text
        name = 'W+ Boson',
        text = {
          'The second Mediator',
          'of the Weak Force.',
          'Mass: 80 GeV!!!!',
          'converts mult into money',
          '{X:mult ,C:white}-#1#{} +{C:money}10${}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'W+Boson', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 90, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = -100 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.mult, -- Add to the multiplier
                colour = G.C.MULT
            }
        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
    calc_dollar_bonus = function(self,card)
        return 10
    end
}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Photon', --atlas key
    path = 'Photon.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Photon', --joker key
    loc_txt = { -- local text
        name = 'Photon',
        text = {
          'The Mediator',
          'of the Electromagnetic Force.',
          'and yes I mean photon the light',
          'particle. Has no mass... ',
          'exibits Wave-Particle Duality',
          '+100 Mult +100 Chips'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Photon', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 120, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 100 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                chips = 100,
            }
        end
        if context.joker_main then
        return {
            card = card,
            mult = card.ability.extra.mult, -- Add to the multiplier
            colour = G.C.MULT
        }

        end
    end,
    
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
----------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Gluon', --atlas key
    path = 'Gluon.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'Gluon', --joker key
    loc_txt = { -- local text
        name = 'Gluon',
        text = {
          'The Mediator',
          'of the Strong Force.',
          'Gluing together Quarks.',
          'Has no mass. Creates Flux tubes! ',
          'With enough Energy, creates a',
          'Quark Pair. Uses Mult to create 2',
          'Subatomic Particles.-150 Mult'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Gluon', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 100, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = -150 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} 
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            local card = create_card('Particle',G.consumeables)
            card:add_to_deck()
            G.consumeables:emplace(card)
            G.GAME.consumeable_buffer = 0
        end
        if context.joker_main then
            local card = create_card('Particle',G.consumeables)
            card:add_to_deck()
            G.consumeables:emplace(card)
            G.GAME.consumeable_buffer = 0
        end
        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.mult, -- Add to the multiplier
                colour = G.C.MULT
            }
        end
    end,
    

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}

--------------------------------------------------
------------- Consumables ------------------------
--------------------------------------------------

SMODS.Atlas{
    key = 'Lambda', --atlas key
    path = 'Lambda.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.ConsumableType{
    key = 'Particle', --consumable type key

    collection_rows = {3,4}, --amount of cards in one page
    primary_colour = G.C.PURPLE, --first color
    secondary_colour = G.C.DARK_EDITION, --second color
    loc_txt = {
        collection = 'SubatomicParticle', --name displayed in collection
        name = 'Subatomic Particle', --name displayed in badge
        undiscovered = {
            name = '???', --undiscovered name
            text = {'?????????????????????????????????????????????????????'} --undiscovered text
        }
    },
    shop_rate = 0.5, --rate in shop out of 100
}

SMODS.UndiscoveredSprite{
    key = 'Particle', --must be the same key as the consumabletype
    atlas = 'UUSP',
    pos = {x = 0, y = 0}
}

SMODS.Consumable{
    key = 'Lambda', --key
    set = 'Particle', --the set of the card: corresponds to a consumable type
    atlas = 'Lambda', --corrected atlas key
    pos = {x = 0, y = 0}, --position in atlas
    loc_txt = {
        name = 'Lambda', --name of card
        text = { --text of card
            'Add +1 Card Limit',
        }
    },
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self, card)
        -- Defensive checks for hand and highlighted cards
        if G and G.hand and G.hand.highlighted then
            local highlighted = G.hand.highlighted
            if #highlighted ~= 0 and #highlighted <= (card.ability.extra.cards or 0) then
                return true
            end
        end
        return true
    end,
    use = function(self, card, area, copier)
       G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end
}
------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Delta', --atlas key
    path = 'Delta.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}


SMODS.Consumable{
    key = 'Delta', --key
    set = 'Particle', --the set of the card: corresponds to a consumable type
    atlas = 'Delta', --corrected atlas key
    pos = {x = 0, y = 0}, --position in atlas
    loc_txt = {
        name = 'Delta Baryon', --name of card
        text = { --text of card
            'Decays down to #1# Subatomic card',
        }
    },
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,

    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return true
    end,
    use = function(self,card,area,copier)

        local card = create_card('Particle',G.consumeables)
        card:add_to_deck()
        G.consumeables:emplace(card)
        G.GAME.consumeable_buffer = 0
    return true

    end,
}

------------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Omega', --atlas key
    path = 'Omega.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}



SMODS.Consumable{
    key = 'Omega', --key
    set = 'Particle', --the set of the card: corresponds to a consumable type
    atlas = 'Omega', --corrected atlas key
    pos = {x = 0, y = 0}, --position in atlas
    loc_txt = {
        name = 'Omega Baryon', --name of card
        text = { --text of card
            'A very Heavy Bryon, Upgrades ALL HANDS... TRICE!',
        }
    },
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,

    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return true
    end,
    use = function(self,card,area,copier)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true)
        end

        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true)
        end

        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true)
        end

    return true

    end,
}

------------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Xi', --atlas key
    path = 'Xi.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}



SMODS.Consumable{
    key = 'Xi', --key
    set = 'Particle', --the set of the card: corresponds to a consumable type
    atlas = 'Xi', --corrected atlas key
    pos = {x = 0, y = 0}, --position in atlas
    loc_txt = {
        name = 'Xi Baryon', --name of card
        text = { --text of card
            'Turns Cards to a Random Value,',
            'Between Ace,2,6,7,8 and 9',

        }
    },
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,

    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)

        local _rank = pseudorandom_element({'2','6','7','8','9','A'}) -- this means Xi in Hex ASCII (btw 0 = A)
        for i=1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({func = function()
                local card = G.hand.cards[i]
                local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                local rank_suffix =_rank
                card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
            return true end }))
        end  

    return true

    end,
}
--------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'Pion', --atlas key
    path = 'Pion.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Consumable{
    key = 'Pion', --key
    set = 'Particle', --the set of the card: corresponds to a consumable type
    atlas = 'Pion', --corrected atlas key
    pos = {x = 0, y = 0}, --position in atlas
    loc_txt = {
        name = 'Pion', --name of card
        text = { --text of card
            'Turns 1 Card into Negative',
        }
    },
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self, card)
        -- Defensive checks for hand and highlighted cards
        if G and G.hand and G.hand.highlighted then
            local highlighted = G.hand.highlighted
            if #highlighted ~= 0 and #highlighted <= (card.ability.extra.cards or 0) then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
        for i = 1, #G.hand.highlighted do 
            --for every card in hand highlighted

            G.hand.highlighted[i]:set_edition({negative = true},true)
        end    
    end,
}
--------------------------------------------------------------------

SMODS.Atlas{
    key = 'Kaon', --atlas key
    path = 'Kaon.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Consumable{
    key = 'Kaon', --key
    set = 'Particle', --the set of the card: corresponds to a consumable type
    atlas = 'Kaon', --corrected atlas key
    pos = {x = 0, y = 0}, --position in atlas
    loc_txt = {
        name = 'Kaon', --name of card
        text = { --text of card
            'Gives +1 Consumable Slot',
        }
    },
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self, card)
        -- Defensive checks for hand and highlighted cards
        if G and G.hand and G.hand.highlighted then
            local highlighted = G.hand.highlighted
            if #highlighted ~= 0 and #highlighted <= (card.ability.extra.cards or 0) then
                return true
            end
        end
        return true 
    end,
    use = function(self,card,area,copier)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
    end,
}
---------------------------------------------------------------------------------------------------------

SMODS.Atlas{
    key = 'D-Meson', --atlas key
    path = 'D-Meson.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
    
SMODS.Consumable{
    key = 'D-Meson', --key
    set = 'Particle', --the set of the card: corresponds to a consumable type
    atlas = 'D-Meson', --corrected atlas key
    pos = {x = 0, y = 0}, --position in atlas
    loc_txt = {
        name = 'D-Meson', --name of card
        text = { --text of card
            'Gives +1 Intrest Cap',
        }
    },
    config = {
        extra = {
            AIC = 5, --configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self, card)
        -- Defensive checks for hand and highlighted cards
        if G and G.hand and G.hand.highlighted then
            local highlighted = G.hand.highlighted
            if #highlighted ~= 0 and #highlighted <= (card.ability.extra.cards or 0) then
                return true
            end
        end
        return true 
    end,
    use = function(self,card,area,copier)
        G.GAME.interest_cap = G.GAME.interest_cap + 5
    end,
    
}

----------------------------------------------------------------------
-------------------------- Other Stuff -------------------------------
----------------------------------------------------------------------
--function Game:init_item_prototypes()
    --self.P_CENTERS = {
        --Charged = {max = 500, order = 9, name = "Charged Card", set = "Enhanced", pos = {x=4,y=1}, effect = "", label = "Charged Card",config = {Xmult = 2.5 }}
    --}
--end