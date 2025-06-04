''' Question:
Given two binary strings a and b, return their sum as a binary string.

 

Example 1:

Input: a = "11", b = "1"
Output: "100"
Example 2:

Input: a = "1010", b = "1011"
Output: "10101"
 

Constraints:

1 <= a.length, b.length <= 104
a and b consist only of '0' or '1' characters.
Each string does not contain leading zeros except for the zero itself.

'''

class Solution:
    def addBinary(self, a: str, b: str) -> str:

        i = 0
        ans= ""
        carry = 0

        while (i < len(a) or i < len(b) or carry != 0):
            x=0
            if (i < len(a) and a[len(a)-i-1] == '1'):
                x=1
            y=0
            if (i < len(b) and b[len(b)-i-1] == '1'):
                y=1
            ans = str((x + y + carry) % 2) + ans
            carry = (x + y + carry) // 2
            i += 1
        return ans