LastLoc = false
CurrentData = false

RegisterNetEvent('mx-spawn:Open')
RegisterNetEvent('mx-multicharacter:GetLastLoc')

AddEventHandler('mx-spawn:Open', function (data)
     if not IsScreenFadedOut() then
          DoScreenFadeOut(0)
     end
     Wait(500)
     DoScreenFadeIn(0)
     while not IsScreenFadedIn() do
          Wait(0)
     end
     CurrentData = data
     SetNuiFocus(true, true)
     SendNUIMessage({
          type = 'open',
     })
end)

RegisterNUICallback('Spawn', function (data)
     SetNuiFocus(false, false)
     local timer = GetGameTimer()
     if data.spawnLoc == 'lastlocation' then
          TriggerServerEvent('mx-multicharacter:GetLastLoc')       
          while not LastLoc do
               Wait(100)
          end   
          SetEntityCoords(PlayerPedId(), LastLoc)
     else
          SetEntityCoords(PlayerPedId(), Cfg.Locs[data.spawnLoc])
     end
     if not IsScreenFadedOut() then
          DoScreenFadeOut(0)
     end
     SwitchOutPlayer(PlayerPedId(), 0, 1)
     while GetPlayerSwitchState() ~= 5 do
          Wait(0)
     end
     DoScreenFadeIn(500)
     while not IsScreenFadedIn() do
          Wait(0)
     end
     while true do
          Wait(0)
          if GetGameTimer() - timer > 5000 then
               SwitchInPlayer(PlayerPedId())
               Wait(4000)
               while GetPlayerSwitchState() ~= 12 do
                   Wait(0)
               end
              
              break
          end
     end
     FreezeEntityPosition(PlayerPedId(), false)
     SetEntityVisible(PlayerPedId(), true)
     if CurrentData then
          TriggerServerEvent('mx-multicharacter:CreateCharacter', CurrentData)
          while not exports['mx-multicharacter']:GetCid() do
               print('Is Nil')
               Wait(100)
          end
     end
     SwitchInPlayer(PlayerPedId())  
     while GetPlayerSwitchState() ~= 12 do
         Wait(0)
     end
     if CurrentData then
          TriggerServerEvent('esx:onPlayerJoined', CurrentData)   
     end
end)

AddEventHandler('mx-multicharacter:GetLastLoc', function (loc)
     LastLoc = loc
end)