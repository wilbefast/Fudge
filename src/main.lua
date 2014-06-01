function love.load(arg)
	fudge = require("fudge")
	f = fudge.new("images",{
		npot = true
		})
	f:export("souls", {imageExtension = "png"})
	--f = fudge.import("souls")
	f:clearb()
	fudge.set("current", f)
	fudge.set("monkey", true)

	f:chopToAnimation("unit_blue_imp_move", 10)
	frame = 1
	frametime = 0
	position = 0

	local tile = f:getPiece("tiles_floor")
	for i=0,love.graphics.getWidth()+tile:getWidth(),tile:getWidth() do
		for j=0,love.graphics.getHeight()+tile:getHeight(),tile:getHeight() do
			f:addb(tile, i, j)
		end
	end

end

function love.update( dt )
	frametime = frametime - dt
	while frametime<=dt do
		frame = (frame%10)+1
		frametime = frametime+(1/20)
	end
	position = position+dt*100
	if position>250 then
		position=-250
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
		love.graphics.getWidth()/2+position-20,
		love.graphics.getHeight()/2+30+math.sin(love.timer.getTime()*10)*3,
		0,0.5,0.5
		)
	love.graphics.draw(
		f.anim["unit_blue_imp_move"][frame],
		love.graphics.getWidth()/2+position,
		love.graphics.getHeight()/2+30
	)

end

function love.keypressed(key, isRepeat)
	if key=='escape' then
		love.event.push('quit')
	end
end