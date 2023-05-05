# Performance-and-cost-comparison-of-16-bit-multipliers

Simulate and synthesize the two designs of a 16-bit adder-based multipliers. Examine the synthesized RTL schematics, and compare the performance of the different designs in terms of the device utilization, delay, etc.

## Combinational design

(referring to the on P185-191)

![image](https://user-images.githubusercontent.com/117464811/236360282-7fe66911-e038-4cbf-93c1-578b1c004417.png)

The algorithm includes 3 tasks:

1. Multiply the digits of the multiplier ($b_4$, $b_3$, $b_2$, $b_1$ and $b_0$) by the multiplicand $A = (a_4, a_3, a_2, a_1, a_0)$ one at a time to obtain $b_4 * A$, $b_3 * A$, $b_2 * A$, $b_1 * A$ and $b_0 * A$.

$$
b_i * A = (a_4 ⋅ b_i, a_3 ⋅ b_i, a_2 ⋅ b_i, a_1 ⋅ b_i, a_0 ⋅ b_i)
$$

2. Shift $b_i * A$ to left by $i$ position.

3. Add the shifted $b_i * A$ terms to obtain the final product.

### Simulation

Some unexpected results are obtained when conducting timing simulation. Possible reason is that the level width of the signal is shorter than the gate delay of this cell.

![1](https://user-images.githubusercontent.com/117464811/236365793-8767d36f-f98e-4ed8-a491-deef47ffac34.png "behavioral")

![2](https://user-images.githubusercontent.com/117464811/236366777-22ecd268-96eb-4fdc-bf38-282cc0e51a98.png "post-synthesis")

![3](https://user-images.githubusercontent.com/117464811/236366925-f5cf4eb3-553c-4a91-822b-95812919f97a.png "post-synthesis")

![4](https://user-images.githubusercontent.com/117464811/236368664-483d4802-834d-495d-9371-0ff7f619ed0f.png "post-implementation")

![5](https://user-images.githubusercontent.com/117464811/236368626-e584f336-e840-443b-92d2-e13f5a626791.png "post-implementation")

### RTL schematic

![image](https://user-images.githubusercontent.com/117464811/236366121-82f5d841-7a67-4b9e-810c-ff542ef31c44.png)









## Repetitive-addition design

(referring to the on P241-259)

### Pseudo-code

```
if (a_in =0 or b_in =0) then{
  r = 0;
}
else{
  a = a_in; n = b_in; r = 0;
  r = r + a;
  n = n - 1;
  if (n = 0) then {
    goto stop;
  }
  else {
    goto op;
  }
}
r_out = r;
```

### ASM chart

The circuit require 3 registers, to store signals $r$, $n$, and $a$ respectively.

![image](https://user-images.githubusercontent.com/117464811/236367900-bea21ebe-c308-43e1-86a7-d41a1e083367.png)

The RT operations:

1. RT operation with the r register:

• r <− r ( in the idle state)

• r <− 0 (in the load and ab0 state)

• r <− r + a ( in the op state)

2. RT operation with the n register:

• n <− n ( in the idle state)

• n <− b_in (in the load and ab0 state)

• n <− n − 1 ( in the op state)

3. RT operation with the a register:

• a <− a ( in the idle and op state)

• a <− a_in (in the load and ab0 state)

### Conceptual diagram

![image](https://user-images.githubusercontent.com/117464811/236368275-7691fa1f-48f7-4a94-9d00-6ac48b38b3ac.png)

### Block diagram

![image](https://user-images.githubusercontent.com/117464811/236368316-c0fb45eb-8729-4c5f-ab11-83c8301da148.png)










## Pipelined design

(referring to the one on P317-330).

Develop an n-bit pipeline design of multiplier where n may be an integer from 1 to 32. Perform the post-layout simulation of the design, and find out the delay, throughput, device utilization, etc., and compare them with that of designs in (1).
