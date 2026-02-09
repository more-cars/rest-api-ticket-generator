---
to: ticket-generator/_temp/ticketTree.json
---
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [{
            "title": "Create <%= h.changeCase.upper(startNodeType) %>-<%= h.changeCase.kebab(relationshipName) %> Relationship",
            "userStory": null,
            "specificationList": [
                "The relationship ›<%= h.changeCase.kebab(relationshipName) %>‹ is created when the provided IDs of the <%= h.changeCase.upper(startNodeType) %> and <%= h.changeCase.upper(endNodeType) %> are valid. -> Status Code `201`",
                "A successful request returns the ID of the created relationship, the relationship name and the relationship partner.",
                "Requests with invalid IDs are rejected. This can happen when there exist no nodes with the given IDs or when those nodes are from the wrong type. -> Status Code `404`",
                "The same ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship between the same nodes can only be created once. Attempts to recreate them will be ignored. -> Status Code `304`",
<% if (cardinality === '1:1' || cardinality === 'n:1') { -%>
                "At the same time a <%= h.changeCase.upper(startNodeType) %> can only be in a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with one <%= h.changeCase.upper(endNodeType) %>"
<% } else if (cardinality === '1:n' || cardinality === 'm:n') { -%>
                "Each <%= h.changeCase.upper(startNodeType) %> can be in a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with multiple <%= h.changeCase.upper(h.inflection.pluralize(endNodeType)) %>"
<% } -%>
            ],
            "apiVerb": "POST",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/<%= h.changeCase.kebab(relationshipName) %>/<<%= h.changeCase.kebab(endNodeType) %>-id>",
            "responseOptions": [
                "201",
                "304",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "Requests to create a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship are accepted when the provided data is valid",
                    "description": "To be valid there need to exist nodes for the provided IDs and the nodes need to be from type <%= h.changeCase.upper(startNodeType) %> resp. <%= h.changeCase.upper(endNodeType) %>.",
                    "responseCode": "201",
                    "tests": [
                        {
                            "title": "Creating a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with valid IDs",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\"')
                                gherkin.push('When the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 201')
                                gherkin.push('And the response should contain the following keys')
                                gherkin.push('| key                  |')
                                gherkin.push('| relationship_id      |')
                                gherkin.push('| relationship_name    |')
                                gherkin.push('| relationship_partner |')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to create a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship are rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.\nThere exists no <%= h.changeCase.upper(endNodeType) %> with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to create a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\"')
                                gherkin.push('When the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to create a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with invalid <%= h.changeCase.upper(endNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\" does NOT exist')
                                gherkin.push('When the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to create a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship where both IDs are invalid",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\" does NOT exist')
                                gherkin.push('When the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "The same ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship between the same nodes can only be created once",
                    "description": "Requests to create the same relationship again are allowed, but they will not be processed. Consecutive attempts will always return an empty 304 response.",
                    "responseCode": "304",
                    "tests": [
                        {
                            "title": "Trying to create the same ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship again",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('When the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then the response should return with status code 304')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
<% if (cardinality === '1:1' || cardinality === 'n:1') { %>
                {
                    "title": "At the same time, each <%= h.changeCase.upper(startNodeType) %> can only be in a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with one <%= h.changeCase.upper(endNodeType) %>",
                    "description": "Connecting a different <%= h.changeCase.upper(endNodeType) %> will delete the previous relationship.",
                    "responseCode": "201",
                    "tests": [
                        {
                            "title": "Creating a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with a different <%= h.changeCase.upper(endNodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + ' (Alternative)\\"')
                                gherkin.push('When the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('Then there should exist a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('When the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + ' (Alternative)\\"')
                                gherkin.push('Then there should exist a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + ' (Alternative)\\"')
                                gherkin.push('But there should exist NO \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
<% } else if (cardinality === '1:n' || cardinality === 'm:n') { %>
                {
                    "title": "Each <%= h.changeCase.upper(startNodeType) %> can be in a ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship with multiple <%= h.changeCase.upper(h.inflection.pluralize(endNodeType)) %>",
                    "description": "There is no limit on the amount of relationships, they just need to be unique.",
                    "responseCode": "201",
                    "tests": [
                        {
                            "title": "Creating multiple ›<%= h.changeCase.kebab(relationshipName) %>‹ relationships",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"' + h.changeCase.upper(endNodeType) + '\\" \\"' + endNodeExampleName + ' (Alternative)\\"')
                                gherkin.push('When the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('And the user creates a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + ' (Alternative)\\"')
                                gherkin.push('Then there should exist a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + '\\"')
                                gherkin.push('And there should exist a \\"' + h.changeCase.lower(relationshipName) + '\\" relationship between \\"' + startNodeExampleName + '\\" and \\"' + endNodeExampleName + ' (Alternative)\\"')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
<% } %>
            ]
        }]
    }
}
