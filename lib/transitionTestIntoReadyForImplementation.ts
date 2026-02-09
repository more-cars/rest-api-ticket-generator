import {transitionJiraTicket} from "./transitionJiraTicket"

export async function transitionTestIntoReadyForImplementation(testId: string) {
    await transitionJiraTicket(testId, '51')
    await transitionJiraTicket(testId, '81')
    await transitionJiraTicket(testId, '191')

    return true
}

export async function transitionTestBackIntoTodo(testId: string) {
    await transitionJiraTicket(testId, '141')
    await transitionJiraTicket(testId, '181')
    await transitionJiraTicket(testId, '201')

    return true
}
