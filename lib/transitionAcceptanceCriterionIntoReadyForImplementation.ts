import {transitionJiraTicket} from "./transitionJiraTicket"

export async function transitionAcceptanceCriterionIntoReadyForImplementation(acceptanceCriterionId: string) {
    await transitionJiraTicket(acceptanceCriterionId, '51')
    await transitionJiraTicket(acceptanceCriterionId, '81')

    return true
}

export async function transitionAcceptanceCriterionBackIntoTodo(acceptanceCriterionId: string) {
    await transitionJiraTicket(acceptanceCriterionId, '141')
    await transitionJiraTicket(acceptanceCriterionId, '181')

    return true
}
