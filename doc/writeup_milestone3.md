## Feedback from Peer Review

The peer review session in lab 3 was an important piece of the process required to take our app from a good start to a little better version of itself. We learned about some of the key missing details and small feature improvements that could change the user experience by a huge degree. We also learned about the usefulness of some features that we created and never thought about! All this emphasized the importance of the review process in building an app or product. Below, we outline some of these key points and comment on our take on the process we went through after receiving the feedback.

### Usability of the App

We observed how our peers used the app and their actions when trying to explore the app for the first time. Most of the users were enamored by the design of the app and went straight into using the map displayed on the main page. They explored how changing the variables on the side panel affected the map and the colors on it. It was only after this that they realized that they didn't understand what the colors stood for and what the app is trying to show or the question it is trying to answer. This was a drawback of our app in a way that it didn't give the users the idea about its purpose on the first look. The main culprit for this issue was the title of the app which was not very intuitive for conveying the purpose of the app. Almost all the peers highlighted this fact and this led to our first simple, yet so important change in the app design. We changed the title of the app to clearly state the purpose of the app and the question that a user can try to answer using the app.

### A few major changes

The second major yet simple design change was the legend title. The previous title confused the users about the percentages used to display colors on the map. Changing the legend title to be more specific led to alleviating this issue. This change made it clear that the numbers shown on the map are not the total number of police shooting instances but represent civilian deaths during these fatal shooting instances across the United States. The fact that this was a major source of confusion among the users of the app did not surprise us, given that we spent more time and effort on making the app look good and do what it is supposed to do instead of focusing on the key aspects of designing an intuitive and easy to use app. This has been an important lesson for us.

One essential change for our app that we had in our minds after Milestone 2 was to have an `all` option for all the dropdown menus that were present on the side panel. This was important as by default, the app should display all the data without any filters and our app displayed filtered data after it loaded directly. It was strange that out of the five people that reviewed the app, there was only one person who noted this shortcoming and mentioned it to us. We have fixed this issue and the app now shows all the data when it is rendered. The user can now see specifically filtered data without any other pre-imposed filters. Implementing this feature took a lot of time and effort from our side as adding conditional filers using `dplyr's` `filter` is not straightforward and simply using an `if_else()` clause inside the filter does not help. We were able to implement this feature using filters outside `filter()` and then using them in `filter()` by checking the presence of the corresponding variable in the selected/required categories.

### Dissecting the feedback received

In this section, we highlight some of the most useful and least useful feedback received from our peers.

Some of the great feedback and improvements points were:

- changing the app title to clearly state the purpose of the app and its usability
- changing legend title to clarify what values is the map exactly showing.
- reducing the precision of the percentages displayed for each state on the map.
- adding a bar chart/table for displaying the top 5-10 states with the highest civilian death percentages (as colors might sometimes be misleading and unclear).
- changing the histogram axis labels (some people found `frequency` as confusing y-axis title in the histogram).
- people liked the overall app design and the color scale choice for the map as well as the display of actual numbers on hover.
- people liked the movability of the side panel with ease and the fade effect of the panel when overlapping with the map for clear vision.

Some less useful feedback:

- displaying NA values on the states with no civilian death cases instead of leaving them white (this would decrease the simplicity of the map and would create more clutter on the screen, a potential source for more confusion).
- overlaying the histogram and the age slider (this would be very difficult to implement as it would require more JavaSript/CSS skills than shiny specific code).
- changing the age histogram on hovering over a state (this might be a useful feature to have but clearly not easy to implement given the time frame for the milestone).

### Reflection and Conclusion

We benefited a lot from the feedback process and it led to some serious and useful design changes. It is important to think and appreciate the value of the review process whether it may be while building an app, a product or learning something new, etc. Though the objective of our app didn't change and we think it might be a useful tool in analyzing unjust civilian deaths, we are aware of the drawbacks such an app has. As mentioned in the previous writeup, a different version of the app might display the information city-wise rather than state-wise but this approach comes with its own drawback as mentioned before already. We decided to stick with our design and show the state-wise data. One more thing to note is that these kinds of choropleth maps essentially are influenced heavily by the population size of any area. We would like to take this into account by obtaining population data from external sources and using it to normalize the data to obtain per-capita values. This might or might not be useful depending on the objective of the app and the user and hence, we have realized that it is not useful to think about implementing a lot of features in a single app as it creates sources of confusion for the users. One direct example is the fact that almost none of the peers who reviewed our app looked at the `Data Explorer` tab in our app which displayed all the available data and allowed users to filter specific examples from the dataset.

To conclude, there might have been a few better design decisions for our app but it is totally dependent on the users of the app. We had a particular set of users in mind while designing the app and this was the source of confusion when a more general public tried to use the app which was a good point to reflect on. Our objective didn't alter much and we implemented the required and suggested changes that led to the newer version of our app making it better than before!
