import { compile, parse } from "fez-lisp";
import { readFileSync, access } from "fs";
const day = process.argv[2];
const path = `./day${day}.lisp`;
access(path, (err) => {
  if (err) {
    console.log(`\x1b[31mSolution for day ${day} does not exist\x1b[33m\n`);
  } else {
    try {
    const solution = new Function(
      `return ${compile(parse(readFileSync(path, "utf-8")))}`
    )();
    if (Array.isArray(solution))
      console.log(
        solution
          .map(
            (x, i) => `\x1b[33m${i === 0 ? " *" : "**"} \x1b[32m${x}\x1b[0m\n`
          )
          .join("\n")
      );
    } catch(err) {
      console.log(`\x1b[31m${err}\x1b[33m\n`);
    }
  }
});
