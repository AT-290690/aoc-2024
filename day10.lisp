(let INPUT (string:concat-with-lines '(
  "89010123"
  "78121874"
  "87430965"
  "96549874"
  "45678903"
  "32019012"
  "01329801"
  "10456732"
)))

(let parse (lambda input (|> input (string:lines) (array:map from:chars->digits))))

(let part1 (lambda matrix (do 
  (let coords (matrix:points matrix math:zero?))
  (array:fold coords (lambda a coord (do
        (let visited (new:set8))
        (let queue (new:queue))
        (let y (array:first coord)) 
        (let x (array:second coord))
        (let current (matrix:get matrix y x))
        (set:add! visited (from:yx->key y x))
        (queue:enqueue! queue (array y x))
        (let score (var:def 0))
        (let rec:while (lambda (unless (queue:empty? queue) (do 
            (let element (queue:peek queue))
            (queue:dequeue! queue)
            (let y (array:first element))
            (let x (array:second element))
            (matrix:adjacent matrix matrix:von-neumann-neighborhood y x (lambda cell dir dy dx (do 
                 (let key (from:yx->key dy dx))
                 (if (and (= (- cell (matrix:get matrix y x)) 1) (not (set:has? visited key))) (do
                    (if (= cell 9) (var:set! score (math:increment (var:get score))) (queue:enqueue! queue (array dy dx)))
                    (set:add! visited key))))))
        (rec:while)))))
        (rec:while)
        (+ a (var:get score)))) 0))))

(let part2 (lambda matrix (do 
  (let coords (matrix:points matrix math:zero?))
  (array:fold coords (lambda a coord (do
        (let visited (new:set8))
        (let queue (new:queue))
        (let y (array:first coord))
        (let x (array:second coord))
        (let current (matrix:get matrix y x))
        (let root-key (from:yx->key y x))
        (map:set! visited root-key 1)
        (queue:enqueue! queue (array y x))
        (let score (var:def 0))
        (let rec:while (lambda (unless (queue:empty? queue) (do 
            (let element (queue:peek queue))
            (let y (array:first element))
            (let x (array:second element))
            (if (= (matrix:get matrix y x) 9) (var:set! score (+ (map:get visited root-key) (var:get score))))
            (queue:dequeue! queue)
            (matrix:adjacent matrix matrix:von-neumann-neighborhood y x (lambda cell dir dy dx (do 
                 (let key (from:yx->key dy dx))
                 (if (= (- cell (matrix:get matrix y x)) 1) (do
                    (queue:enqueue! queue (array dy dx))
                    (if (map:has? visited key) (map:set! visited key (+ (map:get visited root-key) (map:get visited key))) (map:set! visited key (map:get visited root-key))))))))
        (rec:while)))))
        (rec:while)
        (+ a (var:get score)))) 0))))

(let PARSED (parse INPUT))

'((part1 PARSED) (part2 PARSED))