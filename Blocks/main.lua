function love.load()
    love.window.setTitle('Blocks')
    love.graphics.setBackgroundColor(255, 255, 255)

    GridXCount = 10
    GridYCount = 18

    Colors = {
        [' '] = {.87, .87, .87},
        i = {.47, .76, .94},
        j = {.93, .91, .42},
        l = {.49, .85, .76},
        o = {.92, .69, .47},
        s = {.83, .54, .93},
        t = {.97, .58, .77},
        z = {.66, .83, .46},
    }

    SetupInertBlocks();
    SetuptPieceStructures();

    PieceType = 1
    PieceRotation = 1
    PieceX = 3
    PieceY = 0

    BlockSize = 30
    BlockDrawSize = BlockSize - 1

    Timer = 0
end

function love.update(dt)
    Timer = Timer + dt

    if Timer >= 0.5 then
        Timer = 0
        local testY = PieceY + 1
        if CanPieceMove(PieceX, testY, PieceRotation) then
            PieceY = testY
        end
    end
end

function love.draw()
    for x = 1, GridXCount do
        for y = 1, GridYCount do
            DrawBlock(Inert[y][x], x, y)
        end
    end

    for y = 1, 4 do
        for x =1, 4 do
            local block = PieceStructures[PieceType][PieceRotation][y][x]
            if block ~= ' ' then
                DrawBlock(block, x + PieceX, y + PieceY)
            end
        end
    end
end

function love.keypressed(key)
    if key == 'x' then
        local testRotation = PieceRotation + 1
        if testRotation > #PieceStructures[PieceType] then
            testRotation = 1
        end

        if CanPieceMove(PieceX, PieceY, testRotation) then
            PieceRotation = testRotation
        end

    elseif key == 'z' then
        local testRotation = PieceRotation - 1
        if testRotation < 1 then
            testRotation = #PieceStructures[PieceType]
        end

        if CanPieceMove(PieceX, PieceY, testRotation) then
            PieceRotation = testRotation
        end

    elseif key == 'left' then
        local testX = PieceX - 1

        if CanPieceMove(testX, PieceY, PieceRotation) then
            PieceX = testX
        end

    elseif key == 'right' then
        local testX = PieceX + 1

        if CanPieceMove(testX, PieceY, PieceRotation) then
            PieceX = testX
        end
    end
 end

function CanPieceMove(testX, testY, testRotation)
    for y = 1, 4 do
        for x = 1, 4 do
            local block = PieceStructures[PieceType][testRotation][y][x];
            if block ~= ' ' and (testX + x) < 1 then
                return false
            end

            if block ~= ' ' and (testX + x) > GridXCount then
                return false
            end
        end
    end
    
    return true
end

function SetupInertBlocks()
    Inert = {}

    for y = 1, GridYCount do
        Inert[y] = {}
        for x = 1, GridXCount do
            Inert[y][x] = ' '
        end
    end
end

function DrawBlock(blockType, x, y)
    local color = Colors[blockType]
    love.graphics.setColor(color)

    love.graphics.rectangle(
        'fill',
        (x - 1) * BlockSize,
        (y - 1) * BlockSize,
        BlockDrawSize,
        BlockDrawSize
    )
end

function SetuptPieceStructures()
    PieceStructures = {};

    PieceStructures = {
        {
            {
                {' ', ' ', ' ', ' '},
                {'i', 'i', 'i', 'i'},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', 'i', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {' ', 'o', 'o', ' '},
                {' ', 'o', 'o', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'j', 'j', 'j', ' '},
                {' ', ' ', 'j', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'j', ' ', ' '},
                {' ', 'j', ' ', ' '},
                {'j', 'j', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {'j', ' ', ' ', ' '},
                {'j', 'j', 'j', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'j', 'j', ' '},
                {' ', 'j', ' ', ' '},
                {' ', 'j', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'l', 'l', 'l', ' '},
                {'l', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'l', ' ', ' '},
                {' ', 'l', ' ', ' '},
                {' ', 'l', 'l', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', ' ', 'l', ' '},
                {'l', 'l', 'l', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {'l', 'l', ' ', ' '},
                {' ', 'l', ' ', ' '},
                {' ', 'l', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'t', 't', 't', ' '},
                {' ', 't', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 't', ' ', ' '},
                {' ', 't', 't', ' '},
                {' ', 't', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 't', ' ', ' '},
                {'t', 't', 't', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 't', ' ', ' '},
                {'t', 't', ' ', ' '},
                {' ', 't', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {' ', 's', 's', ' '},
                {'s', 's', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {'s', ' ', ' ', ' '},
                {'s', 's', ' ', ' '},
                {' ', 's', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'z', 'z', ' ', ' '},
                {' ', 'z', 'z', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'z', ' ', ' '},
                {'z', 'z', ' ', ' '},
                {'z', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
    }

end
