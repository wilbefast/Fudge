function love.load(arg)
	fudge = require("fudge")
	if __DEBUG__ then
		f = fudge.new("images",{
			npot = false
			})
		f:export("souls", {image_extension = "png", meta_format="lua"})
	else
		f = fudge.import("souls")
	end
	f:clearb()
	fudge.set({
		current = f,
		monkey = true
	})
	f:rename("unit_blue_imp_move", "blueRun")
	f:chopToAnimation("blueRun", 10, {framerate = 24})

	local tile = f:getPiece("tiles_floor")
	for i=0,love.graphics.getWidth()+tile:getWidth(),tile:getWidth() do
		for j=0,love.graphics.getHeight()+tile:getHeight(),tile:getHeight() do
			f:addb(tile, i, j)
		end
	end

end

function love.draw()
	love.graphics.draw(f)
	local logo = f:getPiece("logo")
	love.graphics.draw(logo,
		math.floor(love.graphics.getWidth()/2-logo:getWidth()/2),
		math.floor(love.graphics.getHeight()/2-logo:getHeight()/2+math.sin(love.timer.getTime()*2)*5)
	)
	love.graphics.draw("unit_blue_soul",
		-25+(-love.timer.getTime()*100)%(love.graphics.getWidth()+50)-50,
		love.graphics.getHeight()/2+30+math.sin(love.timer.getTime()*10)*3,
		0,-0.5,0.5
		)
	love.graphics.draw(
		"ani_blueRun",
		-25+(-love.timer.getTime()*100)%(love.graphics.getWidth()+50),
		love.graphics.getHeight()/2+30,
		0, -1, 1
	)

end

function love.keypressed(key, isRepeat)
	if key=='escape' then
		love.event.push('quit')
	end
end