# Performance-and-cost-comparison-of-16-bit-multipliers

Simulate and synthesize the two designs of a 16-bit adder-based multipliers. Examine the synthesized RTL schematics, and compare the performance of the different designs in terms of the device utilization, delay, etc.

## combinational design

(referring to the on P185-191)

![image](https://user-images.githubusercontent.com/117464811/236360282-7fe66911-e038-4cbf-93c1-578b1c004417.png)

The algorithm includes three tasks:
• Multiply the digits of the multiplier ($b_4$, $b_3$, $b_2$, $b_1$ and $b_0$) by the multiplicand $A = (a_4, a_3, a_2, a_1, a_0)$ one at a time to obtain $b_4 * A$, $b_3 * A$, $b_2 * A$, $b_1 * A$ and $b_0 * A$.

$$
b_i * A = (a_4 ⋅ b_i, a_3 ⋅ b_i, a_2 ⋅ b_i, a_1 ⋅ b_i, a_0 ⋅ b_i)
$$

• Shift $b_i * A$ to left by $i$ position.
• Add the shifted $b_i * A$ terms to obtain the final product.

## repetitive-addition design

(referring to the on P241-259)



## pipelined design

(referring to the one on P317-330).

Develop an n-bit pipeline design of multiplier where n may be an integer from 1 to 32. Perform the post-layout simulation of the design, and find out the delay, throughput, device utilization, etc., and compare them with that of designs in (1).
