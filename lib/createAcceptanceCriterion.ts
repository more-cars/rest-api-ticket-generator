import axios from "axios"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"
import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import type {AcceptanceCriterion} from "./types/AcceptanceCriterion"

export async function createAcceptanceCriterion(data: AcceptanceCriterion, parentId: string): Promise<string> {
    const response = await axios
        .post(getJiraApiBaseUrl() + 'issue', {
            fields: {
                'project': {
                    key: 'MCA'
                },
                'issuetype': {
                    id: '10166'
                },
                'parent': {
                    key: parentId
                },
                'summary': data.title,
                'description': {
                    version: 1,
                    type: 'doc',
                    content: [
                        {
                            "type": "paragraph",
                            "content": [
                                {
                                    "type": "text",
                                    "text": data.description,
                                },
                            ]
                        }
                    ]
                },
                'customfield_10801': {
                    id: getMappedResponseCode(data.responseCode)
                },
            }
        }, {
            headers: {
                'Authorization': `Basic ${getJiraApiAuthKey()}`,
                'Content-Type': 'application/json',
            }
        })

    return response.data.key
}

function getMappedResponseCode(responseCode: string) {
    const map = new Map([
        ['200', '10252'],
        ['201', '10253'],
        ['204', '10318'],
        ['301', '10424'],
        ['304', '10385'],
        ['400', '10254'],
        ['401', '10419'],
        ['403', '10420'],
        ['404', '10255'],
        ['422', '10256'],
        ['426', '10422'],
        ['N/A', '10353'],
    ])

    const mappedValue = map.get(responseCode)

    if (!mappedValue) {
        throw new Error(`Unable to find response code ${responseCode}`)
    }

    return mappedValue
}
