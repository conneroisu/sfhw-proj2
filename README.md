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
graph LR
    %% IF Stage
    PC[Program Counter] --> IM[Instruction Memory]
    PC --> ADD_IF[Add]
    ADD_IF --> MUX_IF[MUX]
    MUX_IF --> PC
    
    %% ID Stage
    IM --> REG_READ1[Read register 1]
    IM --> REG_READ2[Read register 2]
    IM --> REG_WRITE[Write register]
    IM --> SIGN_EXT[Sign-extend]
    
    %% EX Stage
    REG_READ1 --> ALU
    REG_READ2 --> MUX_ALU[ALU MUX]
    MUX_ALU --> ALU
    SIGN_EXT --> MUX_ALU
    SIGN_EXT --> SHIFT_LEFT[Shift left 2]
    SHIFT_LEFT --> ADD_EX[Add]
    
    %% MEM Stage
    ALU --> DATA_MEM[Data Memory]
    
    %% WB Stage
    DATA_MEM --> WB_MUX[Write Back MUX]
    WB_MUX --> REG_WRITE
    
    %% Stage Labels
    subgraph IF[IF: Instruction Fetch]
        PC
        IM
        ADD_IF
        MUX_IF
    end
    
    subgraph ID[ID: Instruction Decode]
        REG_READ1
        REG_READ2
        REG_WRITE
        SIGN_EXT
    end
    
    subgraph EX[EX: Execute]
        ALU
        MUX_ALU
        SHIFT_LEFT
        ADD_EX
    end
    
    subgraph MEM[MEM: Memory Access]
        DATA_MEM
    end
    
    subgraph WB[WB: Write Back]
        WB_MUX
    end
    
    %% Enforce stage ordering
    IF --> ID --> EX --> MEM --> WB
    
    %% Styling
    classDef stageStyle fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    class IF,ID,EX,MEM,WB stageStyle
    
    %% Direction
    direction LR

    click PC "https://github.com/conneroisu/sfhw-proj2/blob/main/proj/src/TopLevel/Fetch/program_counter.vhd" "Program Counter"
```
