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

// TODO: all constants need to be double checked
import "github.com/slockit/DAO/DAO.sol";

contract Withdraw {
    DAO constant public mainDAO = DAO(0xbb9bc244d798123fde783fcc1c72d3bb8c189413);
    uint constant public totalSupply = 11538165987024671407837618;
    uint constant public totalWeiSupply = 11898333978710775162018627;

function withdraw(address donateExtraBalanceTo){
        uint balance = mainDAO.balanceOf(msg.sender);

        // The msg.sender must call approve(this, balance) beforehand so that
        // transferFrom() will work and not throw. We need transferFrom()
        // instead of transfer() due to the msg.sender in the latter ending
        // up to be the contract
        if (!mainDAO.transferFrom(msg.sender, this, balance)
            || !msg.sender.send(balance)
            || !donateExtraBalanceTo.send(balance * totalWeiSupply / totalSupply - balance)) {

            throw;
        }
    }
}
