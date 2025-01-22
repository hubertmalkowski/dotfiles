async function loadFile() {
  const foo = Bun.file("dark.json"); // relative to cwd
  return await foo.json();
}

function getUniqueValues(obj) {
  const values = Object.values(obj);
  return new Set(values);
}

const file = await loadFile();

const values = getUniqueValues(file);
console.log(values);
