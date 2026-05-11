import type {TicketTree} from "./types/TicketTree"
import {createStory} from "./createStory"
import {connectStoryToEpic} from "./connectStoryToEpic"
import {createAcceptanceCriterion} from "./createAcceptanceCriterion"
import {createTest} from "./createTest"
import {connectTestToAcceptanceCriterion} from "./connectTestToAcceptanceCriterion"
import {transitionStoryIntoReadyForImplementation} from "./transitionStoryIntoReadyForImplementation"
import {transitionAcceptanceCriterionIntoReadyForImplementation} from "./transitionAcceptanceCriterionIntoReadyForImplementation"
import {transitionTestIntoReadyForImplementation} from "./transitionTestIntoReadyForImplementation"

export async function createTickets(data: TicketTree) {
    const createdStories = []
    const createdAcs = []
    const createdTests = []

    for (const story of data.epic.stories) {
        const storyTicket = await createStory(story)
        createdStories.push(storyTicket.key)
        await transitionStoryIntoReadyForImplementation(storyTicket.key)
        await connectStoryToEpic(storyTicket.key, data.epic.jiraId)

        for (const acceptanceCriterion of story.acceptanceCriteria) {
            const acceptanceCriterionTicket = await createAcceptanceCriterion(acceptanceCriterion, storyTicket.key)
            createdAcs.push(acceptanceCriterionTicket.key)
            await transitionAcceptanceCriterionIntoReadyForImplementation(acceptanceCriterionTicket.key)

            for (const test of acceptanceCriterion.tests) {
                const testId = await createTest(test)
                createdTests.push(testId)
                await transitionTestIntoReadyForImplementation(testId)
                await connectTestToAcceptanceCriterion(testId, acceptanceCriterionTicket.key)
            }
        }
    }

    return {
        epicId: data.epic.jiraId,
        stories: createdStories,
        acceptanceCriteria: createdAcs,
        tests: createdTests,
    }
}
