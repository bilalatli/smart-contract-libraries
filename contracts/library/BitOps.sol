//SPDX-License-Identifier: GNU
pragma solidity ^0.8.0;

/**
 * @title Bit Operations
 * @author <Bilal ATLI>
 * @dev Make bit operations on unsigned integer variables
 */
library BitOps {

    /**
     * @dev AND operator
     * x        = 1010
     * y        = 0011
     * x & y    = 0010
     */
    function and(uint x, uint y) internal pure returns (uint) {
        return x & y;
    }

    /**
     * @dev OR operator
     * x        = 1010
     * y        = 0011
     * x & y    = 1011
     */
    function or(uint x, uint y) internal pure returns (uint) {
        return x | y;
    }

    /**
     * @dev XOR operator
     * x        = 1010
     * y        = 0011
     * x & y    = 1001
     */
    function xor(uint x, uint y) internal pure returns (uint) {
        return x ^ y;
    }

    /**
     * @dev NOT operator
     * x        = 1010
     * ~x       = 0101
     */
    function not(uint x) internal pure returns (uint) {
        return ~x;
    }

    /**
     * @dev Left shift for `n` bits
     * (1 << 0) = 0001 --> 0001
     * (1 << 1) = 0001 --> 0010
     * (1 << 2) = 0001 --> 0100
     * (1 << 3) = 0001 --> 1000
     */
    function leftShift(uint x, uint n) internal pure returns (uint) {
        return x << n;
    }

    /**
     * @dev Right shift for `n` bits
     * (8 >> 0) = 1000 --> 1000
     * (8 >> 1) = 1000 --> 0100
     * (8 >> 2) = 1000 --> 0010
     * (8 >> 3) = 1000 --> 0001
     */
    function rightShift(uint x, uint n) internal pure returns (uint) {
        return x >> n;
    }

    /**
     * @dev Get last `n` bits
     * x            = 1110
     * n            = 2
     * mask         = 0111 = ((1 << 2) - 1)
     * x & mask     = 0110
     */
    function lastNBits(uint x, uint n) internal pure returns (uint) {
        return x & ((1 << n) - 1);
    }

    /**
     * @dev Get `n`th bit
     * x                = 1110
     * n                = 2
     * mask             = 0100 = (1 << 2)
     * x & mask         = 0100
     * (x & mask) >> n  = 0001
     */
    function nthBit(uint x, uint n) internal pure returns (uint) {
        uint mask = (1 << n);
        return (x & mask) >> n;
    }

    /**
     * @dev Set `n`th bit
     * x                = 1110
     * n                = 2
     * mask             = 0100 = (1 << 2)
     * ~mask            = 1011 = ~(1 << 2)
     * ---------- State: false (zero bit) ----------
     * x                = 1110
     * ~mask            = 1011
     * x & ~mask        = 1010
     * ---------- State: true (one bit) ----------
     * x                = 1110
     * mask             = 0100
     * x | mask         = 1110
     */
    function setNthBit(uint x, uint n, bool state) internal pure returns (uint) {
        if (state) {
            return (x | (1 << n));
        } else {
            return (x & ~(1 << n));
        }
    }

    /**
     * @dev Toggle `n`th bit
     * Look `setNthBit`
     */
    function toggleBit(uint x, uint n) internal pure returns (uint) {
        if (((x & (1 << n)) >> n) == 0x1) {
            return (x | (1 << n));
        } else {
            return (x & ~(1 << n));
        }
    }
}
