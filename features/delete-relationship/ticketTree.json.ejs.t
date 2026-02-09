---
to: ticket-generator/_temp/ticketTree.json
---
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [{
            "title": "Delete <%= h.changeCase.upper(startNodeType) %>-<%= h.changeCase.kebab(relationshipName) %> Relationship",
            "userStory": "As an API contributor\nI want to be able to disconnect <%= h.changeCase.upper(h.inflection.pluralize(endNodeType)) %> from <%= h.changeCase.upper(h.inflection.pluralize(startNodeType)) %>\nSo I can clean up bad data or test data",
            "specificationList": [
                "The ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship is deleted when it actually exists. -> Status Code `204`",
                "A successful request returns with an empty body.",
                "Requests with invalid IDs are rejected. This can happen when there exist no nodes with the given IDs or when those nodes are from the wrong type. -> Status Code `404`",
                "Requests are rejected when there exists no ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship between the provided nodes. -> Status Code `404`"
            ],
            "apiVerb": "DELETE",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/<%= h.changeCase.kebab(relationshipName) %>/<<%= h.changeCase.kebab(endNodeType) %>-id>",
            "responseOptions": [
                "204",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "The ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship is deleted when the provided data is valid",
                    "description": "To be valid there need to exist nodes for the provided IDs and the first node needs to be a <%= h.changeCase.upper(startNodeType) %> and the second node needs to be a <%= h.changeCase.upper(endNodeType) %>.",
                    "responseCode": "204",
                    "tests": [
                        {
                            "title": "Deleting the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship when it actually exists",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship \\"R\\" between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('When the user deletes the \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 204')
                                gherkin.push('And the relationship \\"R\\" should not exist anymore')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to delete the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship are rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.\nThere exists no <%= h.changeCase.upper(endNodeType) %> with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to delete a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\"')
                                gherkin.push('When the user deletes the \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to delete a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with invalid <%= h.changeCase.upper(endNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\" does NOT exist')
                                gherkin.push('When the user deletes the \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to delete a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship where both IDs are invalid",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\" does NOT exist')
                                gherkin.push('When the user deletes the \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to delete the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship are rejected when the relationship does not exist",
                    "description": "The relationship might have never existed or it has already been deleted. No matter the reason, an error will be returned.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to delete a non-existent ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\"')
                                gherkin.push('And there exists NO \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('When the user deletes the \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
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
