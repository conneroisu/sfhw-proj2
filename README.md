> ### Report: https://docs.google.com/document/d/10988V4THck_VjlVM9gS4_aE0piDJ1uK7xjHn-jshYB0/edit?usp=sharing
> ### Spreadsheet: https://docs.google.com/spreadsheets/d/1RUNOOiJ3DZ2heZ5_la7ENw52pGrtweVW7ax-dkXzsRU/edit?usp=sharing
>
> ### WhenToMeet: https://www.when2meet.com/?27331718-g3Ah7

# sfhw-proj2

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
```stl
solid cube_corner
  facet normal 0.0 -1.0 0.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 1.0 0.0 0.0
      vertex 0.0 0.0 1.0
    endloop
  endfacet
  facet normal 0.0 0.0 -1.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 0.0 1.0 0.0
      vertex 1.0 0.0 0.0
    endloop
  endfacet
  facet normal -1.0 0.0 0.0
    outer loop
      vertex 0.0 0.0 0.0
      vertex 0.0 0.0 1.0
      vertex 0.0 1.0 0.0
    endloop
  endfacet
  facet normal 0.577 0.577 0.577
    outer loop
      vertex 1.0 0.0 0.0
      vertex 0.0 1.0 0.0
      vertex 0.0 0.0 1.0
    endloop
  endfacet
endsolid
```

```mermaid


graph TD
    A[Start] --> B[Process 1]
    B --> C{Decision?}
    C -->|Yes| D[Process 2]
    C -->|No| E[End]
    A --> F[Additional Info]
    
    click A "https://example.com/start" "Go to the Start"
    click B "https://example.com/process1" "Details about Process 1"
    click C "https://example.com/decision" "Decision Point Details"
    click D "https://example.com/process2" "Details about Process 2"
    click E "https://example.com/end" "Learn more about the End"
    click F "https://example.com/info" "Additional information"

```
