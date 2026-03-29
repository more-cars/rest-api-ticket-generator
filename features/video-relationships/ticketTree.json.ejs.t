---
to: _temp/ticketTree.json
---
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [
        {
            "title": "Create <%= h.changeCase.upper(startNodeType) %>-has-video Relationship",
            "userStory": "As an API contributor\nI want to be able to attach VIDEOS to a <%= h.changeCase.upper(startNodeType) %>\nSo an API consumer can illustrate the <%= h.changeCase.upper(startNodeType) %> node in a frontend application",
            "specificationList": [
                "The relationship ›has-video‹ is created when the provided IDs of the <%= h.changeCase.upper(startNodeType) %> and VIDEO are valid. -> Status Code `201`",
                "A successful request returns the ID of the created relationship, the relationship name and the relationship partner.",
                "Requests with invalid IDs are rejected. This can happen when there exist no nodes with the given IDs or when those nodes are from the wrong type. -> Status Code `404`",
                "The same ›has-video‹ relationship between the same nodes can only be created once. Attempts to recreate them will be ignored. -> Status Code `304`",
                "Each <%= h.changeCase.upper(startNodeType) %> can be in a ›has-video‹ relationship with multiple VIDEOS"
            ],
            "apiVerb": "POST",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/has-video/<video-id>",
            "responseOptions": [
                "201",
                "304",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "Requests to create a ›has-video‹ relationship are accepted when the provided data is valid",
                    "description": "To be valid there need to exist nodes for the provided IDs and the nodes need to be from type <%= h.changeCase.upper(startNodeType) %> resp. VIDEO.",
                    "responseCode": "201",
                    "tests": [
                        {
                            "title": "Creating a ›has-video‹ relationship with valid IDs",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('When the user creates a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be confirmed with status code 201')
                                gherkin.push('And the response should contain the following keys')
                                gherkin.push('| key                  |')
                                gherkin.push('| relationship_id      |')
                                gherkin.push('| relationship_name    |')
                                gherkin.push('| start_node           |')
                                gherkin.push('| partner_node         |')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to create a ›has-video‹ relationship are rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.\nThere exists no VIDEO with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to create a ›has-video‹ relationship with invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('When the user creates a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to create a ›has-video‹ relationship with invalid VIDEO ID",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And \\"VIDEO\\" \\"Promo Video\\" does NOT exist')
                                gherkin.push('When the user creates a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to create a ›has-video‹ relationship where both IDs are invalid",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And \\"VIDEO\\" \\"Promo Video\\" does NOT exist')
                                gherkin.push('When the user creates a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "The same ›has-video‹ relationship between the same nodes can only be created once",
                    "description": "Requests to create the same relationship again are allowed, but they will not be processed. Consecutive attempts will always return an empty 304 response.",
                    "responseCode": "304",
                    "tests": [
                        {
                            "title": "Trying to create the same ›has-video‹ relationship again",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('And there exists a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('When the user creates a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the response should return with status code 304')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Each <%= h.changeCase.upper(startNodeType) %> can be in a ›has-video‹ relationship with multiple VIDEOS",
                    "description": "There is no limit on the amount of relationships, they just need to be unique.",
                    "responseCode": "201",
                    "tests": [
                        {
                            "title": "Creating multiple ›has-video‹ relationships",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video (Part 2)\\"')
                                gherkin.push('When the user creates a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('And the user creates a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video (Part 2)\\"')
                                gherkin.push('Then there should exist a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('And there should exist a \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video (Part 2)\\"')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        },
        {
            "title": "Get all <%= h.changeCase.upper(startNodeType) %>-has-video Relationships",
            "userStory": "As an API consumer\nI want to be able to fetch all VIDEOS that are connected to a <%= h.changeCase.upper(startNodeType) %>\nSo I can find out more about it - be it in form of a review, a promo video or a podcast",
            "specificationList": [
                "A list of all ›has-video‹ relationships for the selected <%= h.changeCase.upper(startNodeType) %> is returned when there exists at least one of them. -> Status Code `200`",
                "Each item in the list contains the ID of the created relationship, the relationship name and the relationship partner.",
                "An empty list is returned when no ›has-video‹ relationship exists. -> Status Code `200`",
                "Requests with invalid ID are rejected. This can happen when there exists no node with the given ID or it is not a <%= h.changeCase.upper(startNodeType) %>. -> Status Code `404`"
            ],
            "apiVerb": "GET",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/has-video",
            "responseOptions": [
                "200",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "A list of all ›has-video‹ relationships is returned when the provided data is valid",
                    "description": "To be a valid request the provided ID has to point to a <%= h.changeCase.upper(startNodeType) %> node that actually exists.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting the ›has-video‹ relationships when at least one exists",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exist 3 \\"has-video\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('When the user requests all \\"has-video\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('And the response should return a collection with 3 \\"has-video\\" relationships')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "An empty list is returned when there exist no ›has-video‹ relationships for the given <%= h.changeCase.upper(startNodeType) %>",
                    "description": "",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting the ›has-video‹ relationships when there are none",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exist 0 \\"has-video\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('When the user requests all \\"has-video\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('And the response should return an empty list')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "A request to fetch all ›has-video‹ relationships is rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to fetch the ›has-video‹ relationships with an invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('When the user requests all \\"has-video\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        },
        {
            "title": "Delete <%= h.changeCase.upper(startNodeType) %>-has-video Relationship",
            "userStory": "As an API contributor\nI want to be able to disconnect VIDEOS from <%= h.changeCase.upper(h.inflection.pluralize(startNodeType)) %>\nSo I can clean up bad data or test data",
            "specificationList": [
                "The ›has-video‹ relationship is deleted when it actually exists. -> Status Code `204`",
                "A successful request returns with an empty response.",
                "Requests with invalid IDs are rejected. This can happen when there exist no nodes with the given IDs or when those nodes are from the wrong type. -> Status Code `404`",
                "Requests are rejected when there exists no ›has-video‹ relationship between the provided nodes. -> Status Code `404`"
            ],
            "apiVerb": "DELETE",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/has-video/<video-id>",
            "responseOptions": [
                "204",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "The ›has-video‹ relationship is deleted when the provided data is valid",
                    "description": "To be valid there need to exist nodes for the provided IDs and the first node needs to be a <%= h.changeCase.upper(startNodeType) %> and the second node needs to be a VIDEO.",
                    "responseCode": "204",
                    "tests": [
                        {
                            "title": "Deleting the ›has-video‹ relationship when it actually exists",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('And there exists a \\"has-video\\" relationship \\"R\\" between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('When the user deletes the \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be confirmed with status code 204')
                                gherkin.push('And the relationship \\"R\\" should not exist anymore')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to delete the ›has-video‹ relationship are rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.\nThere exists no VIDEO with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to delete a ›has-video‹ relationship with invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('When the user deletes the \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to delete a ›has-video‹ relationship with invalid VIDEO ID",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And \\"VIDEO\\" \\"Promo Video\\" does NOT exist')
                                gherkin.push('When the user deletes the \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to delete a ›has-video‹ relationship where both IDs are invalid",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And \\"VIDEO\\" \\"Promo Video\\" does NOT exist')
                                gherkin.push('When the user deletes the \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to delete the ›has-video‹ relationship are rejected when the relationship does not exist",
                    "description": "The relationship might have never existed or it has already been deleted. No matter the reason, an error will be returned.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to delete a non-existent ›has-video‹ relationship",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('And there exists NO \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('When the user deletes the \\"has-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        },
        {
            "title": "Create <%= h.changeCase.upper(startNodeType) %>-has-main-video Relationship",
            "userStory": "As an API contributor\nI want to be able to select the main VIDEO of a <%= h.changeCase.upper(startNodeType) %>\nSo an API consumer can instantly load the VIDEO that best represents the <%= h.changeCase.upper(startNodeType) %>",
            "specificationList": [
                "The relationship ›has-main-video‹ is created when the provided IDs of the <%= h.changeCase.upper(startNodeType) %> and VIDEO are valid. -> Status Code `201`",
                "A successful request returns the ID of the created relationship, the relationship name and the relationship partner.",
                "Requests with invalid IDs are rejected. This can happen when there exist no nodes with the given IDs or when those nodes are from the wrong type. -> Status Code `404`",
                "The same ›has-main-video‹ relationship between the same nodes can only be created once. Attempts to recreate them will be ignored. -> Status Code `304`",
                "At the same time a <%= h.changeCase.upper(startNodeType) %> can only be in a ›has-main-video‹ relationship with one VIDEO"
            ],
            "apiVerb": "POST",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/has-main-video/<video-id>",
            "responseOptions": [
                "201",
                "304",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "Requests to create a ›has-main-video‹ relationship are accepted when the provided data is valid",
                    "description": "To be valid there need to exist nodes for the provided IDs and the nodes need to be from type <%= h.changeCase.upper(startNodeType) %> resp. VIDEO.",
                    "responseCode": "201",
                    "tests": [
                        {
                            "title": "Creating a ›has-main-video‹ relationship with valid IDs",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('When the user creates a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be confirmed with status code 201')
                                gherkin.push('And the response should contain the following keys')
                                gherkin.push('| key                  |')
                                gherkin.push('| relationship_id      |')
                                gherkin.push('| relationship_name    |')
                                gherkin.push('| start_node           |')
                                gherkin.push('| partner_node         |')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to create a ›has-main-video‹ relationship are rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.\nThere exists no VIDEO with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to create a ›has-main-video‹ relationship with invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('When the user creates a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to create a ›has-main-video‹ relationship with invalid VIDEO ID",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And \\"VIDEO\\" \\"Promo Video\\" does NOT exist')
                                gherkin.push('When the user creates a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to create a ›has-main-video‹ relationship where both IDs are invalid",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And \\"VIDEO\\" \\"Promo Video\\" does NOT exist')
                                gherkin.push('When the user creates a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "The same ›has-main-video‹ relationship between the same nodes can only be created once",
                    "description": "Requests to create the same relationship again are allowed, but they will not be processed. Consecutive attempts will always return an empty 304 response.",
                    "responseCode": "304",
                    "tests": [
                        {
                            "title": "Trying to create the same ›has-main-video‹ relationship again",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('And there exists a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('When the user creates a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the response should return with status code 304')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "At the same time, each <%= h.changeCase.upper(startNodeType) %> can only be in a ›has-main-video‹ relationship with one VIDEO",
                    "description": "Connecting a different VIDEO will delete the previous relationship.",
                    "responseCode": "201",
                    "tests": [
                        {
                            "title": "Creating a ›has-main-video‹ relationship with a different VIDEO",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video (Part 2)\\"')
                                gherkin.push('When the user creates a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then there should exist a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('When the user creates a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video (Part 2)\\"')
                                gherkin.push('Then there should exist a \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video (Part 2)\\"')
                                gherkin.push('But there should exist NO \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        },
        {
            "title": "Get <%= h.changeCase.upper(startNodeType) %>-has-main-video Relationship",
            "userStory": "As an API consumer\nI want to be able to get the main VIDEO of a <%= h.changeCase.upper(startNodeType) %>\nSo I can instantly load the VIDEO that best represents the <%= h.changeCase.upper(startNodeType) %>",
            "specificationList": [
                "The ›has-main-video‹ relationship for the selected <%= h.changeCase.upper(startNodeType) %> is returned when one exists. -> Status Code `200`",
                "The response contains the relationship ID, the relationship name and the relationship partner.",
                "An empty response is returned when the selected <%= h.changeCase.upper(startNodeType) %> has no ›has-main-video‹ relationship. -> Status Code `200`",
                "Requests with invalid ID are rejected. This can happen when there exists no node with the given ID or it is not a <%= h.changeCase.upper(startNodeType) %>. -> Status Code `404`"
            ],
            "apiVerb": "GET",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/has-main-video",
            "responseOptions": [
                "200",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "The ›has-main-video‹ relationship is returned when the provided data is valid",
                    "description": "To be a valid request the provided ID has to point to a <%= h.changeCase.upper(startNodeType) %> node that actually exists.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting the ›has-main-video‹ relationship when one exists",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"has-main-video\\" relationship \\"R\\" for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('When the user requests the \\"has-main-video\\" relationship for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('And the response should return the relationship \\"R\\"')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "An empty response is returned when there exists no ›has-main-video‹ relationship for the given <%= h.changeCase.upper(startNodeType) %>",
                    "description": "",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting the ›has-main-video‹ relationship when there exists none",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists NO \\"has-main-video\\" relationship for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('When the user requests the \\"has-main-video\\" relationship for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('But the response should return an empty body')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to fetch the ›has-main-video‹ relationship are rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to fetch the ›has-main-video‹ relationship with an invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('When the user requests the \\"has-main-video\\" relationship for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        },
        {
            "title": "Delete <%= h.changeCase.upper(startNodeType) %>-has-main-video Relationship",
            "userStory": "As an API contributor\nI want to be able to disconnect the main VIDEO from a <%= h.changeCase.upper(startNodeType) %>\nSo I can clean up bad data or test data",
            "specificationList": [
                "The ›has-main-video‹ relationship is deleted when it actually exists. -> Status Code `204`",
                "A successful request returns with an empty response.",
                "Requests with invalid IDs are rejected. This can happen when there exist no nodes with the given IDs or when those nodes are from the wrong type. -> Status Code `404`",
                "Requests are rejected when there exists no ›has-main-video‹ relationship between the provided nodes. -> Status Code `404`"
            ],
            "apiVerb": "DELETE",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/has-main-video/<video-id>",
            "responseOptions": [
                "204",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "The ›has-main-video‹ relationship is deleted when the provided data is valid",
                    "description": "To be valid there need to exist nodes for the provided IDs and the first node needs to be a <%= h.changeCase.upper(startNodeType) %> and the second node needs to be a VIDEO.",
                    "responseCode": "204",
                    "tests": [
                        {
                            "title": "Deleting the ›has-main-video‹ relationship when it actually exists",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('And there exists a \\"has-main-video\\" relationship \\"R\\" between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('When the user deletes the \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be confirmed with status code 204')
                                gherkin.push('And the relationship \\"R\\" should not exist anymore')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to delete the ›has-main-video‹ relationship are rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.\nThere exists no VIDEO with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to delete a ›has-main-video‹ relationship with invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('When the user deletes the \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to delete a ›has-main-video‹ relationship with invalid VIDEO ID",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And \\"VIDEO\\" \\"Promo Video\\" does NOT exist')
                                gherkin.push('When the user deletes the \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        },
                        {
                            "title": "Trying to delete a ›has-main-video‹ relationship where both IDs are invalid",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('And \\"VIDEO\\" \\"Promo Video\\" does NOT exist')
                                gherkin.push('When the user deletes the \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "Requests to delete the ›has-main-video‹ relationship are rejected when the relationship does not exist",
                    "description": "The relationship might have never existed or it has already been deleted. No matter the reason, an error will be returned.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to delete a non-existent ›has-main-video‹ relationship",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exists a \\"VIDEO\\" \\"Promo Video\\"')
                                gherkin.push('And there exists NO \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('When the user deletes the \\"has-main-video\\" relationship between \\"' + startNodeExampleName + '\\" and \\"Promo Video\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        }
        ]
    }
}
