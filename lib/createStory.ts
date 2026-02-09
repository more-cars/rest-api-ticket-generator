import axios from "axios"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"
import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import type {Story} from "./types/Story"

export async function createStory(data: Story): Promise<string> {
    const payload = getPayload(data)

    const response = await axios
        .post(getJiraApiBaseUrl() + 'issue', payload, {
            headers: {
                'Authorization': `Basic ${getJiraApiAuthKey()}`,
                'Content-Type': 'application/json',
            }
        })

    return response.data.key
}

function getPayload(data: Story) {
    return {
        fields: {
            'project': {
                key: 'MCA'
            },
            'issuetype': {
                id: '10001'
            },
            'summary': data.title,
            'description': {
                version: 1,
                type: 'doc',
                content: [
                    getSpecificationList(data.specificationList),
                ]
            },
            'customfield_10691': {
                version: 1,
                type: 'doc',
                content: [
                    {
                        "type": "paragraph",
                        "content": [
                            {
                                "type": "text",
                                "text": data.userStory || '',
                            },
                        ]
                    }
                ]
            },
            'customfield_10732': {
                id: getMappedApiVerb(data.apiVerb)
            },
            'customfield_10731': data.apiPath,
            'customfield_10767': getResponseOptionsList(data.responseOptions)
        }
    }
}

function getSpecificationList(data: string[]) {
    const specs: any[] = []

    data.forEach(spec => {
        specs.push({
            "type": "listItem",
            "content": [{
                "type": "paragraph",
                "content": [{
                    "type": "text",
                    "text": spec,
                }]
            }]
        })
    })

    return {
        "type": "bulletList",
        "content": specs
    }
}

function getMappedApiVerb(verb: string) {
    const map = new Map([
        ['GET', '10186'],
        ['POST', '10187'],
        ['PATCH', '10188'],
        ['DELETE', '10189'],
        ['N/A', '10351'],
    ])

    const mappedValue = map.get(verb)

    if (!mappedValue) {
        throw new Error(`Unable to find verb ${verb}`)
    }

    return mappedValue
}

function getResponseOptionsList(options: string[]) {
    const mappedOptions: { value: string }[] = []

    options.forEach(option => {
        mappedOptions.push({value: option})
    })

    return mappedOptions
}
