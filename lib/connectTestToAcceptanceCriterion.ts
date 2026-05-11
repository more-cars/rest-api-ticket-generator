import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"

export async function connectTestToAcceptanceCriterion(testId: string, acceptanceCriterion: string) {
    await fetch(getJiraApiBaseUrl() + 'issueLink', {
        method: 'POST',
        headers: {
            'Authorization': `Basic ${getJiraApiAuthKey()}`,
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            type: {
                name: "Test"
            },
            inwardIssue: {
                key: testId,
            },
            outwardIssue: {
                key: acceptanceCriterion,
            },
        })
    })
}
