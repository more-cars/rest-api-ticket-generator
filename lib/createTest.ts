import axios from "axios"
import type {Test} from "./types/Test"
import {loadGraphqlQuery} from "./loadGraphqlQuery"
import {getXrayGraphqlUrl} from "./getXrayGraphqlUrl"
import {obtainXrayApiToken} from "./obtainXrayApiToken"

export async function createTest(data: Test): Promise<string> {
    let query = loadGraphqlQuery('createTest.gql')
    let gherkin = data.gherkin.replace(/\r?\n/g, '\\n')
    gherkin = gherkin.replace(/"/g, '\\"')
    query = query.replace('$gherkin', gherkin)
    query = query.replace('$title', data.title)

    const xrayResponse = await axios
        .post(getXrayGraphqlUrl(), {
            query
        }, {
            headers: {
                'Authorization': `Bearer ${await obtainXrayApiToken()}`
            }
        })

    return xrayResponse.data.data.createTest.test.jira.key
}
