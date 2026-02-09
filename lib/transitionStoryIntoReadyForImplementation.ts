import {transitionJiraTicket} from "./transitionJiraTicket"

export async function transitionStoryIntoReadyForImplementation(storyId: string) {
    await transitionJiraTicket(storyId, '201')
    await transitionJiraTicket(storyId, '51')
    await transitionJiraTicket(storyId, '81')

    return true
}

export async function transitionStoryBackIntoTodo(storyId: string) {
    await transitionJiraTicket(storyId, '141')
    await transitionJiraTicket(storyId, '181')
    await transitionJiraTicket(storyId, '211')

    return true
}
