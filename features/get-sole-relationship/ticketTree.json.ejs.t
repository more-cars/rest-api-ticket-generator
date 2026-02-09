---
to: ticket-generator/_temp/ticketTree.json
---
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [{
            "title": "Get <%= h.changeCase.upper(startNodeType) %>-<%= h.changeCase.kebab(relationshipName) %> Relationship",
            "userStory": null,
            "specificationList": [
                "The ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship for the selected <%= h.changeCase.upper(startNodeType) %> is returned when one exists. -> Status Code `200`",
                "The response contains the relationship ID, the relationship name and the relationship partner.",
                "An empty response is returned when the selected <%= h.changeCase.upper(startNodeType) %> has no ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship. -> Status Code `200`",
                "Requests with invalid ID are rejected. This can happen when there exists no node with the given ID or it is not a <%= h.changeCase.upper(startNodeType) %>. -> Status Code `404`"
            ],
            "apiVerb": "GET",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/<%= h.changeCase.kebab(relationshipName) %>",
            "responseOptions": [
                "200",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "The ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship is returned when the provided data is valid",
                    "description": "To be a valid request the provided ID has to point to a <%= h.changeCase.upper(startNodeType) %> node that actually exists.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship when one exists",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship \\"R\\" for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('When the user requests the \\"' + h.changeCase.lower(relationshipName) + '\\" relationship for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('And the response should return the relationship \\"R\\"')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "An empty response is returned when there exists no ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship for the given <%= h.changeCase.upper(startNodeType) %>",
                    "description": "",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship when there exists none",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists NO \\"' + h.changeCase.lower(relationshipName) + '\\" relationship for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('When the user requests the \\"' + h.changeCase.lower(relationshipName) + '\\" relationship for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('But the response should return an empty body')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to fetch the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship are rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to fetch the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with an invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('When the user requests the \\"' + h.changeCase.lower(relationshipName) + '\\" relationship for \\"' + startNodeExampleName + '\\"')
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
