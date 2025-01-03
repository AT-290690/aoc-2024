import { fez } from "fez-lisp";
import { readFileSync, access } from "fs";
const day = process.argv[2];
const path = `./day${day}.lisp`;
access(path, (err) => {
  if (err) {
    console.log(`\x1b[31mSolution for day ${day} does not exist\x1b[33m\n`);
  } else {
    const file = readFileSync(path, "utf-8");
    const solution = eval(
      fez(file, {
        mutation: 1,
        compile: 0,
      })
    );
    if (Array.isArray(solution))
      console.log(
        solution
          .map(
            (x, i) => `\x1b[33m${i === 0 ? " *" : "**"} \x1b[32m${x}\x1b[0m\n`
          )
          .join("\n")
      );
  }
});
