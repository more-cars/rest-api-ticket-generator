import axios from "axios"
import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"

export async function connectTestToAcceptanceCriterion(testId: string, acceptanceCriterion: string) {
    await axios
        .post(getJiraApiBaseUrl() + 'issueLink', {
            type: {
                name: "Test"
            },
            inwardIssue: {
                key: testId,
            },
            outwardIssue: {
                key: acceptanceCriterion,
            },
        }, {
            headers: {
                'Authorization': `Basic ${getJiraApiAuthKey()}`,
                'Content-Type': 'application/json',
            }
        })
}
