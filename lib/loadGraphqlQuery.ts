import fs from 'node:fs'

export function loadGraphqlQuery(path: string) {
    return fs.readFileSync(__dirname + '/' + path, 'utf8')
}
