(let sample (array:concat-with '(
"MMMSXXMASM"
"MSAMXMSMSA"
"AMXSXMAAMM"
"MSAMASMSMX"
"XMASAMXAMM"
"XXAMMXXAMA"
"SMSMSASXSS"
"SAXAMASAAA"
"MAMMMXMMMM"
"MXMXAXMASX") char:new-line))

(let parse (lambda input (|> input (string:lines))))
(let part1 (lambda matrix (do 
    (let coords ())
    (matrix:enumerated-for matrix (lambda char y x (if (= char char:X) (array:push! coords (array y x)))))
    (let pattern "XMAS")
    (let size (length pattern))
    (let out (var:def 0))
    (let seek (lambda matrix y x Y X i (do 
            (let dy (+ y (* Y i)))
            (let dx (+ x (* X i)))
            (if (and (matrix:in-bounds? matrix dy dx) (and (<= i size) (= (get pattern i) (matrix:get matrix dy dx))))
                    (cond 
                        (= i (- size 1)) (var:set! out (+ (var:get out) 1))
                        (*) (seek matrix y x Y X (+ i 1)))))))
    (array:for coords (lambda coord (do 
        (let y (array:first coord))
        (let x (array:second coord))
        (array:for matrix:moore-neighborhood (lambda dir (seek matrix y x (array:first dir) (array:second dir) 1))))))
    (var:get out))))

(let part2 (lambda matrix (do 
    (let coords ())
    (matrix:enumerated-for matrix (lambda char y x (if (= char char:A) (array:push! coords (array y x)))))
    (array:fold (array:select coords (lambda dir (and (matrix:in-bounds? matrix (+ (array:first dir) -1) (+ (array:second dir) -1)) (matrix:in-bounds? matrix (+ (array:first dir) 1) (+ (array:second dir) 1))))) (lambda a coord (do 
        (let y (array:first coord))
        (let x (array:second coord))
        (let A (matrix:get matrix (+ y -1) (+ x -1)))
        (let B (matrix:get matrix (+ y -1) (+ x 1)))
        (let C (matrix:get matrix (+ y 1) (+ x -1)))
        (let D (matrix:get matrix (+ y 1) (+ x 1)))
        (+ a (or 
            (and (= A char:M) (= B char:S) (= C char:M) (= D char:S))
            (and (= A char:S) (= B char:M) (= C char:S) (= D char:M))
            (and (= A char:M) (= B char:M) (= C char:S) (= D char:S))
            (and (= A char:S) (= B char:S) (= C char:M) (= D char:M)))))) 0))))
(let PARSED (parse sample))
'((part1 PARSED) (part2 PARSED))