//SPDX-License-Identifier: GNU

pragma solidity ^0.8.0;

import "./BitOps.sol";

/**
 * @title Account permission library
 * @author <Bilal ATLI>
 * @dev Account permission management with BitWise operations.
 *   Max permission index is 256 for now. It can be developed in future
 */
library AccountPermissions {
    using BitOps for uint;

    /**
     * @dev Add bytes32 mask for avoid address hash collisions on standard storage slots
     */
    bytes32 constant BYTES_MASK = 0xFFFFFFFF00000000000000000000000000000000000000000000000000000000;

    /**
     * @dev Permission data struct
     */
    struct AccountBitmaskPermission {
        uint data;
    }

    /**
     * @dev Permission index check for bit overflow
     */
    modifier indexRangeCheck(uint index) {
        require(index <= 255, "Permission index overflow");
        _;
    }

    /**
     * @dev Get struct storage slot
     */
    function _permissionStorage(address a) private pure returns (AccountBitmaskPermission storage ap) {
        bytes32 position = keccak256(abi.encodePacked(a)) | BYTES_MASK;
        assembly {
            ap.slot := position
        }
    }

    /**
     * @dev Check permission of given account has granted with `permIndex`
     */
    function hasPermission(address a, uint permIndex) internal indexRangeCheck(permIndex) pure returns (bool) {
        AccountBitmaskPermission memory perms = _permissionStorage(a);
        return (perms.data.nthBit(permIndex) == 1);
        //return (BitOps.nthBit(perms.data, permIndex) == 1);
    }

    /**
     * @dev Grant permission of given account with `permIndex`
     */
    function grantPermission(address a, uint permIndex) internal indexRangeCheck(permIndex) {
        AccountBitmaskPermission storage perms = _permissionStorage(a);
        perms.data = perms.data.setNthBit(permIndex, true);
        //perms.data = BitOps.setNthBit(perms.data, permIndex, true);
    }

    /**
     * @dev Revoke permission of given account with `permIndex`
     */
    function revokePermission(address a, uint permIndex) internal indexRangeCheck(permIndex) {
        AccountBitmaskPermission storage perms = _permissionStorage(a);
        perms.data = perms.data.setNthBit(permIndex, false);
        //perms.data = BitOps.setNthBit(perms.data, permIndex, false);
    }

    /**
     * @dev Clear all permissions of given account
     */
    function clearAllPermissions(address a) internal {
        AccountBitmaskPermission storage perms = _permissionStorage(a);
        perms.data = 0;
    }

    /**
     * @dev Grant all permission of given account
     */
    function grantAllPermissions(address a) internal {
        AccountBitmaskPermission storage perms = _permissionStorage(a);
        perms.data = (2 ** 256) - 1;
    }

    /**
     * @dev Get storage slot key for given account
     */
    function getSlotKey(address a) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(a)) | BYTES_MASK;
    }
}
