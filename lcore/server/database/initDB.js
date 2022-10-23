{
    const fs = require('fs');
    const baseDir = `./resources/${GetCurrentResourceName()}/server/database`

    async function initDB() {
        let init = fs.readFileSync(`${baseDir}/versions/init.sql`).toString()
        console.log("Going to apply initial SQL patch")
        await sqlClient.query(init)

        fs.readdir(`${baseDir}/versions`, async (err, files) => {
            if (err)
                console.log(err);
            else {
                let sortedFiles = []
                for (let i in files) {
                    let file=parseInt(files[i].replace(".sql", ""))
                    if (typeof file === "number" && isFinite(file)) {
                        sortedFiles.push(file)
                    }
                }
                sortedFiles.sort((a, b) => a - b)

                for (let version of sortedFiles) {
                    let query = fs.readFileSync(`${baseDir}/versions/${version}.sql`).toString()
                    console.log("Going to apply SQL patch for version : "+version)
                    await sqlClient.query(query)
                }
            }
        })
    }

    initDB()
}

