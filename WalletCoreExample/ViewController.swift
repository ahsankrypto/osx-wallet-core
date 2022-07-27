// Copyright © 2017-2020 Trust Wallet.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Cocoa
import WalletCore
import Foundation
import CommonCrypto
import CryptoKit


class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let wallet = HDWallet(mnemonic: "ripple scissors kick mammal hire column oak again sun offer wealth tomorrow wagon turn fatal", passphrase: "")!
        print("Mnemonic: ", wallet.mnemonic)

       
        // Bitcoin example
        let coin:CoinType = .bitcoin
        
        // Get the default address
        let privateKey = wallet.getKey(coin: .bitcoin, derivationPath: "m/84'/0'/0'/0/0");
        let publicKey = privateKey.getPublicKeySecp256k1(compressed: true);
        let privateKeyString = privateKey.data.hexString
        
        print("Address", coin.deriveAddress(privateKey: privateKey));
        print("Pubkey", privateKey.getPublicKeySecp256k1(compressed: true).data.hexString);
        print("PrivKey Simple Format", privateKeyString)
        
        let WIF = "80" + privateKeyString + "01"
        
        guard let data = WIF.data(using: .utf8) else { return }
        let digest = SHA256.hash(data: data)
        print(digest.data) // 32 bytes
        print(digest.hexStr)
         
        print(WIF)
        // Build a transaction
    }
}
 
