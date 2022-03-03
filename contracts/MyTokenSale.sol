// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Crowdsale.sol";
import "./KycContract.sol";

contract MyTokenSale is Crowdsale {
    KycContract kyc;

    constructor(
        uint256 rate,    // rate in TKNbits
        address payable wallet,
        ERC20 token,
        KycContract _kyc
    )
        Crowdsale(rate, wallet, token)
    {
        kyc = _kyc;
    }

    function _preValidatePurchase (
        address _beneficiary,
        uint256 _weiAmount
    )
        internal
        view
        override
    {
        super._preValidatePurchase(_beneficiary, _weiAmount);
        require(kyc.KycCompleted(msg.sender), "KYC Not Completed, purchase not allowed");
    }
}