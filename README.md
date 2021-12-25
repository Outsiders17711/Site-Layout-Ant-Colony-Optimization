<p align="right">
<img src="https://badges.pufler.dev/visits/Outsiders17711/Site-Layout-Ant-Colony-Optimization?style=for-the-badge&logo=github" alt="https://github.com/Outsiders17711" />&nbsp;
<img src="https://badges.pufler.dev/updated/Outsiders17711/Site-Layout-Ant-Colony-Optimization?style=for-the-badge&logo=github" alt="https://github.com/Outsiders17711" />&nbsp;
<img src="https://badges.pufler.dev/created/Outsiders17711/Site-Layout-Ant-Colony-Optimization?style=for-the-badge&logo=github" alt="https://github.com/Outsiders17711" />&nbsp;
</p>

<!--  -->
# Site-Layout-Ant-Colony-Optimization
<p align=left style="font-size: x-large"><b>Oluwaleke Umar Yusuf</b></p>

    Implementing the Ant Colony Optimization (ACO) algorithm from scratch in MATLAB. 
    Solving the site-level facilities layout problem. 
    Creating functions for pretty-printing the pheromone weights and visualizing the solutions.

---

Construction site-level facilities layout is an important activity in site planning. The objective of this activity is to allocate appropriate locations and areas for temporary site-level facilities such as warehouses, job offices, various workshops and batch plants. Depending on the size, location, and nature of the project, the required temporary facilities may vary. The layout of facilities has an important impact on the production time and cost savings, especially for large projects. 

In this implementation, a construction site-level facility layout problem is described as allocating a set of predetermined facilities into a set of predetermined places, while satisfying layout constraints and requirements. The **Ant Colony Optimization (ACO)** algorithm is used to determine the optimal allocation of facilities to locations on the site that **minimizes the total traveling distance of site personnel between facilities**.

> <p><b>Reference Paper: Heng Li & Peter E. D. Love - <a href="https://ascelibrary.org/doi/abs/10.1061/%28ASCE%290887-3801%281998%2912%3A4%28227%29" style="text-decoration: none;"><i>Site-Level Facilities Layout Using Genetic Algorithms</i></a></b></p>

---

**Optimum Solution:**

The optimum solution -- representIng Facility@Location-pair information -- found was **[ 9 11 5 6 7 2 4 1 3 8 10 ]** i.e.

> **[ F1@L9 , F2@L11 , F3@L5 , F4@L6 , F5@L7 , F6@L2 , F7@L4 , F8@L1 , F9@L3 , F10@L8 , F11@L10 ]**


The solution was arrived at after 33 iterations with an ant colony population size of 50. The figure below shows that the pheromone matrix values (left) and normalized pheromone weights and best (optimum) solution (right) at iteration 33.

<a><img src="https://github.com/Outsiders17711/Site-Layout-Ant-Colony-Optimization/blob/master/Optimum%20Solution.jpg?raw=true" title="Best Solution & Pheromone Weights" alt="Best Solution & Pheromone Weights" style="width:1000px;"></a>


**Best Solution & Pheromone Weights Across Iterations:**

<a><img src="https://github.com/Outsiders17711/Site-Layout-Ant-Colony-Optimization/blob/master/printPheromoneWeights-33-Iterations.gif?raw=true" title="Best Solution & Pheromone Weights Across Iterations" alt="Best Solution & Pheromone Weights Across Iterations" style="width:600px;"></a>

<!-- add link to post -->
<!-- There is a walkthrough of the code implementation on my blog. You can check it out **[here]()**. -->

---
