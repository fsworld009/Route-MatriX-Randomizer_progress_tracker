/**
 * check_id_table.js
 * 2025/08/23 by fsworld009
 * Utility to create 'item_id_table.txt' and 'check_id_table.txt' for progress_tracker lua script
 *
 * Usage: node check_id_table.js path/to/RouteMatriXRandomizer092/data path/to/progress_tracker/data
 * Tested in Nodejs v24.4.1
 */

const path = require('path');
const fs = require('fs').promises;


(async function main(){
  const folderInput = process.argv[2];
  const folderPath = path.resolve(__dirname, folderInput);

  try {
    await fs.readdir(folderPath);
  } catch (e) {
    console.log('Unable to open folder', folderPath);
    console.error(e);
    process.exit(1);
  }

  const filenames = ['idItem.json', 'idCheck.json'];
  const outputTableFilenames = ['item_id_table.txt', 'check_id_table.txt']
  for (let i=0; i < filenames.length; i+=1) {
    const filename = filenames[i];
    const outputFilename = outputTableFilenames[i];
    let content;
    try {
      content = await fs.readFile(path.resolve(folderPath, filename));
    } catch (e) {
      console.log('Unable to read content of', filename);
      console.error(e);
      process.exit(1);
    }
    try {
      let outputs = [];
      let idList = JSON.parse(content);  // content is supposed to be a list of {k: string, v: number}
      // Remove duplicates in source content
      idList = idList.map((id) => JSON.stringify(id));
      idList = [... new Set(idList)].map((idStr) => JSON.parse(idStr));

      idList.forEach((id) => {
        outputs.push([id.v, `${id.v}=${id.k}`]);
        /**
         * For items, we need to create English IDs for "Multi world" items that number ID
         * starts at 768. These IDs are referenced in boot.lua (acquiredItem)
         * but don't have English ID in JSON.
         * Create these IDs from 1xxxx (Item 0~255) by
         * 1. Offset num ID to 768+num
         * 2. Replace the first letter `1` to `M` e.g. `MItLifeUp1`  `MItEnergyUp1`
         */
        if (filename === 'idItem.json' && id.k[0] === '1') {
          const multiWorldNumId = id.v + 768;
          const multiWorldEngId = `M${id.k.substr(1)}`;
          outputs.push([multiWorldNumId, `${multiWorldNumId}=${multiWorldEngId}`]);
        }
      });
      outputs = outputs.sort((a, b) => a[0] - b[0]).map((item) => item[1]);
      await fs.writeFile(
        path.resolve(process.argv[3], outputFilename),
        outputs.join('\n'),
      );
      console.log('created', outputFilename);
    } catch (e) {
      console.log(`Failed to parse the content of ${filename} and create table file for lua script.`);
      console.error(e);
      process.exit(1);
    }
  }
  console.log('done');
})();
