/*
This file is part of the DAO.

The DAO is free software: you can redistribute it and/or modify
it under the terms of the GNU lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version. As a contributor, by requesting that your materials gets merged into this repository, you agree to an outright assignment of your copyright of such materials to the DAO. By submitting a proposal, you agree to an outright assignment of your copyright to the DAO of the proposal itself AND work done by you or subcontractors in furtherance of fulfillment of the proposal. Your contribution will be released under the terms of the GNU lesser General Public License.

The DAO is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  Furthermore, any user of this software expressly knows and agrees that the user is using this software at the user’s sole risk. The user acknowledges that the user has an adequate understanding of the risks, usage and intricacies of this software, cryptographic tokens and blockchain-based open source software, eth platform and ethereum. The user acknowledges and agrees that, to the fullest extent permitted by any applicable law, the disclaimers of liability contained herein apply to any and all damages or injury whatsoever caused by or related to risks of, use of, or inability to use this software, ethereum or the Ethereum platform under any cause or action whatsoever of any kind in any jurisdiction, including, without limitation, actions for breach of warranty, breach of contract or tort (including negligence) and that neither copyright holder(s), distributor(s), or contributor(s) of this software, Stiftung Ethereum (i.e. Ethereum Foundation) nor Ethereum team shall be liable for any indirect, incidental, special, exemplary or consequential damages, including for loss of profits, goodwill or data that occurs as a result. Limitation of liability shall apply even if the risks and possibility of such damage was known or should have been known. Limitation of liability shall apply even if the copyright holder(s), distributor(s), or contributor(s) of this software, Stiftung Ethereum, or the Ethereum team were advised of the possibility of such damage. Some jurisdictions do not allow the exclusion of certain warranties or the limitation or exclusion of liability for certain types of damages. Therefore, some of the above limitations in this section may not apply to a user. 

You should have received a copy of the GNU lesser General Public License
along with the DAO.  If not, see <http://www.gnu.org/licenses/>. See the GNU lesser General Public License for more details.
*/


/*
  Sample Proposal from a Contractor to the DAO including a reward towards the
  DAO.

  Feel free to use as a template for your own proposal.
*/

import "./Offer.sol";

contract RewardOffer is Offer {

    uint rewardDivisor;
    uint deploymentReward;

    function RewardOffer(
        address _contractor,
        address _client,
        bytes32 _hashOfTheProposalDocument,
        uint _totalCost,
        uint _initialWithdrawal,
        uint128 _minDailyWithdrawalLimit,
        uint _payoutFreezePeriod
    ) Offer(
        _contractor,
        _client,
        _hashOfTheProposalDocument,
        _totalCost,
        _initialWithdrawal,
        _minDailyWithdrawalLimit,
        _payoutFreezePeriod) {
    }

    function setRewardDivisor(uint _rewardDivisor) onlyClient noEther {
        rewardDivisor = _rewardDivisor;
    }

    function setDeploymentReward(uint _deploymentReward) onlyClient noEther {
        deploymentReward = _deploymentReward;
    }

    // non-value-transfer getters
    function getRewardDivisor() noEther constant returns (uint) {
        return rewardDivisor;
    }

    function getDeploymentReward() noEther constant returns (uint) {
        return deploymentReward;
    }
}
