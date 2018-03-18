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
    DAO constant public mother = DAO(0xbb9bc244d798123fde783fcc1c72d3bb8c189413);
    mapping (address => bool) public blackList;
    uint constant public totalSupply = 11712722930974665882186911;
    uint constant public totalWeiSupply = 12072858342395652843028271;
    uint constant public fixChildDAOsListTime = 1468057560; // 09.07.2016 - 11:46:00 CEST

    function Withdraw(){
        // These are the child DAOs where the recursive call exploit was used,
        // their token balances are invalid.
        blackList[0xb136707642a4ea12fb4bae820f03d2562ebff487] = true;
        blackList[0x304a554a310c7e546dfe434669c62820b7d83490] = true;
        blackList[0x84ef4b2357079cd7a7c69fd7a37cd0609a679106] = true;
        blackList[0xf4c64518ea10f995918a454158c6b61407ea345c] = true;
        blackList[0x4613f3bca5c44ea06337a9e439fbc6d42e501d0a] = true;
        blackList[0xaeeb8ff27288bdabc0fa5ebb731b6f409507516c] = true;
        blackList[0xfe24cdd8648121a43a7c86d289be4dd2951ed49f] = true;
    }

    /// This function can be used to redeem child dao tokens.
    /// It can only be called 4 weeks after the blacklist was fixed.
    /// The reason is that if this more complicated mechanism has a flaw,
    /// people will hopefully already have withdrawn most of the ether
    /// through the simpler mechanism below.
    function withdrawFromChildDAO(uint _childProposalID) {
        if (now < fixChildDAOsListTime + 4 weeks) throw;
        DAO child = DAO(mother.getNewDAOAddress(_childProposalID));
        // If the child is blacklisted or too new, this does not work.
        if (address(child) == 0 || blackList[child] || child.lastTimeMinQuorumMet() > fixChildDAOsListTime)
            throw;

        withdraw(child);
    }

    /// Withdraw your share of the Ether.
    /// Prior to calling this function, you have to approve allow the withdraw
    /// contract to transfer your DAO tokens to it.
    function withdraw() {
        withdraw(mother);
    }

    function withdraw(DAO dao) internal {
        uint balance = dao.balanceOf(msg.sender);

        // The msg.sender must call approve(this, balance) beforehand so that
        // transferFrom() will work and not throw. We need transferFrom()
        // instead of transfer() due to the msg.sender in the latter ending
        // up to be the contract
        if (!dao.transferFrom(msg.sender, this, balance)
            || !msg.sender.send(balance * totalWeiSupply / totalSupply)) {

            throw;
        }
    }
}
