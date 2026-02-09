---
to: ticket-generator/_temp/ticketTree.json
---
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [{
            "title": "Get <%= h.changeCase.upper(nodeType) %> Node by ID",
            "userStory": "As an API consumer\nI want to be able to request a specific <%= h.changeCase.upper(nodeType) %>\nSo I can find out all the details about it when I only have its ID",
            "specificationList": [
                "The requested <%= h.changeCase.upper(nodeType) %> node is returned when the provided ID is valid. -> Status Code `200`",
                "A successful request returns the node with all specified properties.",
                "Properties are returned, even when they are empty (optional fields). They are returned with value `null`.",
                "Requests with invalid ID are rejected. This case can happen when there exists no node with that ID or when the node is not from type <%= h.changeCase.upper(nodeType) %>. -> Status Code `404`"
            ],
            "apiVerb": "GET",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(nodeType)) %>/<<%= h.changeCase.kebab(nodeType) %>-id>",
            "responseOptions": [
                "200",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "Requesting a <%= h.changeCase.upper(nodeType) %> with a valid ID returns the respective node",
                    "description": "An ID is deemed valid when there exists a node with that ID AND the node is from type <%= h.changeCase.upper(nodeType) %>.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting a <%= h.changeCase.upper(nodeType) %> with valid ID",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user requests the \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('Then the response should return with status code 200')
                                gherkin.push('And the response should return the \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "Requests are rejected when there exists no <%= h.changeCase.upper(nodeType) %> with the provided ID",
                    "description": "When there exists no node with the provided ID -> rejected.\nWhen there exists a node with the provided ID, but it is not from type <%= h.changeCase.upper(nodeType) %> -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Requesting a <%= h.changeCase.upper(nodeType) %> with invalid ID",
                            <%
                                gherkin = []
                                gherkin.push('When the user requests a non-existing \\"' + h.changeCase.upper(nodeType) + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        }]
    }
}
