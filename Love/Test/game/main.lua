function love.load()
  startpressed = false
  startbegin = false
  t = {}
  text = {}
  text.cooldown = 0
  text.cooldownspeed = 4
  text.message = ""
  text.array = {"Long ago, two races \nruled over Earth: \nHUMANS and MONSTERS.", "One day, war broke \nout between the two \nraces.", "After a long battle, \nthe humans were \nvictorious.", "They sealed the monsters \nunderground with a magic \nspell.",  "Many years later...", "MT. EBOTT\n  201X", "Legends say that those \nwho climb the mountain \nnever return."}
  text.str = text.array[1]
  text_setup()
  text.index = 1
  text.messageindex = 1
  text.timearray = {-130, -160, -170, -130, -220, -260, -200}
  text.timedelay = text.timearray[1]
  text.alignarray = {13, 13, 13, 13, 13, 110, 13}
  text.align = text.alignarray[1]
end

function program_start()
  local music = love.audio.newSource('intro-tex/intro.wav', 'stream')
  music:setLooping(false)
  love.audio.play(music)
  intro = {}
  intro.font = love.graphics.newFont("intro-tex/determination.ttf")
  intro.image = {love.graphics.newImage("intro-tex/1.png"), love.graphics.newImage("intro-tex/2.png"), love.graphics.newImage("intro-tex/3.png"), love.graphics.newImage("intro-tex/4.png"), love.graphics.newImage("intro-tex/5.png"), love.graphics.newImage("intro-tex/6.png"), love.graphics.newImage("intro-tex/7.png"), love.graphics.newImage("intro-tex/8.png"), love.graphics.newImage("intro-tex/9.png"), love.graphics.newImage("intro-tex/10.png"), love.graphics.newImage("intro-tex/11.png"), love.graphics.newImage("intro-tex/12.png")}
  intro.y = {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, -478, 10}
  intro.first = true
  intro.arraytwo = {-200, -200, -200, -200, -200, -200}
  intro.arraytwoindex = 1
  intro.final = true
  intro.logo = love.graphics.newImage("intro-tex/logosmaller.png")
  intro.logodisplay = false
  intro.bars = love.graphics.newImage("intro-tex/bars.png")
end

function text_setup()
  text.str:gsub(".",function(c) table.insert(t,c) end)
end

function love.update (dt)
  if startbegin then
    if text.cooldown <= 0 then
      if text.index <= #text.str then
        text.message = text.message .. t[text.index]
        text.cooldown = text.cooldownspeed
        text.index = text.index + 1
      else
        if text.cooldown <= text.timedelay then
          if text.messageindex <= 6 then
            text.messageindex = text.messageindex + 1
            text.timedelay = text.timearray[text.messageindex]
            text.align = text.alignarray[text.messageindex]
            text.index = 1
            text.message = ""
            t = {}
            text.str = text.array[text.messageindex]
            text_setup()
          elseif text.messageindex <= 9 then
            if text.cooldown <= intro.arraytwo[intro.arraytwoindex] then
              text.message = ""
              text.messageindex = text.messageindex + 1
              text.cooldown = 0
              intro.arraytwoindex = intro.arraytwoindex + 1
            else
              text.cooldown = text.cooldown - 1
            end
          else
            if intro.first then
              text.messageindex = text.messageindex + 1
              intro.first = false
            else
              if text.cooldown <= -400 then
                if intro.y[11] <= 10 then
                  intro.y[11] = intro.y[11] + 1
                else
                  if text.cooldown <= -750 then
                    text.messageindex = 12
                    if text.cooldown <= -873 then
                      intro.logodisplay = true
                    else
                      text.cooldown = text.cooldown - 1
                    end
                  else
                    text.cooldown = text.cooldown - 1
                  end
                end
              else
                text.cooldown = text.cooldown - 1
              end
            end
          end
        else
          text.cooldown = text.cooldown - 1
        end
      end
    else
      text.cooldown = text.cooldown - 1
    end
  end
end

function love.gamepadpressed(joy, button)
  if button == "start" then
    if startpressed == false then
      program_start()
      startpressed = true
      startbegin = true
    else
      love.event.quit()
    end
  end
end

function love.draw()
  if startbegin then
    love.graphics.setScreen('top')
    love.graphics.setColor(1,1,1)
    love.graphics.draw(intro.image[text.messageindex], 0, intro.y[text.messageindex])
    if intro.logodisplay then
      love.graphics.draw(intro.logo, 10, 102)
    end
    love.graphics.setScreen('bottom')
    love.graphics.setFont(intro.font)
    love.graphics.print(text.message, text.align, 70)
    love.graphics.setScreen('top')
    love.graphics.setColor(0,0,0)
    love.graphics.draw(intro.bars, 0, -10)
    love.graphics.draw(intro.bars, 0, 230)
  else
    love.graphics.print("Press Start to Begin")
  end
end