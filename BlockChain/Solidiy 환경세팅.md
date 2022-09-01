# Solidiy 환경세팅

1. node 환경 세팅
   
   ```bash
   $ npm i
   ```

2. `truffle` 설치
   
   ```bash
   $ npm install -g truffle
   ```

3. `truffle` 폴더 생성
   
   ```bash
   $ mkdir truffle
   ```

4. 폴더 내부에서 truffle 시작
   
   ```bash
   $ truffle init
   ```
   
   * 에러 발생
     
     ```bash
     + CategoryInfo          : 보안 오류: (:) [], PSSecurityException
     + FullyQualifiedErrorId : UnauthorizedAccess
     ```
   
   * 해결
     
     ```bash
     $ truffle.cmd init
     ```

5. 메인에서 다시 `openzepplin` 설치
   
   ```bash
   $ npm install @openzeppelin/contracts
   ```

6. hdwallet 라이브러리 설치
   
   ```bash
   $ npm install @truffle/hdwallet-provider
   ```

7. ropsten에 배포
   
   ```bash
   $ truffle migrate --compile-all --network ropsten
   ```
   
   ```
   You must specify a network_id in your 'ropsten' configuration in order to use this network.
   ```
   
   오류 해결: `truffle-config.js`
   
   ```js
   ropsten: {
       provider: function () {
           return new HDWalletProvider(MNEMONIC, "https://ropsten.infura.io/v3/dcf676ddcf9a40a68b9ec811d8fb355d");
       },
       network_id: "*", //모두로 변
       },
   ```
   
   * `networks` 항목 아래에 넣어야 함을 주의

8. infura ropsten 테스트
   
   *  접속
   
   ```bash
    $ truffle.cmd console --network ropsten
   ```
*    `truffle/migrations` 아래 설정 파일은 무조건 다음과 같다.
  
  ```
  1_initial_migration.js
  ```

* 명령어 사용해 테스트
  
  ```bash
  $ accounts[0]
  ```
  
  ```bash
  truffle(ropsten)> instance = await AnimalNFT.deployed()
  truffle(ropsten)> instance.name()
  truffle(ropsten)> instance.symbol()
  ```

* NFT Stoage에서 tokenURI 생성해놓기
  
  ```url
  https://nft.storage/
  ```

* 다시 NFT 등록
  
  ```bash
  truffle(ropsten)> instance.mintNFT(accounts[0], "ipfs://bafkreih7ukp3wocszra2t6icmyyx6a57kg5hxkpbijs5bjofig6w3hf3f4")
  ```
  
  ```
  {
    tx: '0x92b4975cdd32737650425d4209d5e3baf8b5c69e41b1a6fbbfcf4eea287dee7f',
    receipt: {
      blockHash: '0x99c7d5a65bd48bb6c671810ea2ae4e11210ee4a47cd1e3a04cffbdae9556ca65',
      blockNumber: 12905615,
      contractAddress: null,
      cumulativeGasUsed: 5147688,
      effectiveGasPrice: 2500000007,
      from: '0x172ab7431bdbde9e485b477bf0f434ab7b219bb6',
      gasUsed: 185665,
      logs: [ [Object] ],
      logsBloom: '0x000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000400000000000000000000000000080000000000400000000400000000000000000000000000000a0000000000000000000800000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000001000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000',
      status: true,
      to: '0xf56b501839ad09f7e979370d9d38017c6d870438',
      transactionHash: '0x92b4975cdd32737650425d4209d5e3baf8b5c69e41b1a6fbbfcf4eea287dee7f',
      transactionIndex: 4,
      type: '0x2',
      rawLogs: [ [Object] ]
    },
    logs: [
      {
        address: '0xF56B501839AD09f7E979370d9D38017c6d870438',
        blockHash: '0x99c7d5a65bd48bb6c671810ea2ae4e11210ee4a47cd1e3a04cffbdae9556ca65',
        blockNumber: 12905615,
        logIndex: 9,
        removed: false,
        transactionHash: '0x92b4975cdd32737650425d4209d5e3baf8b5c69e41b1a6fbbfcf4eea287dee7f',
        transactionIndex: 4,
        id: 'log_5e1aa3ef',
        event: 'Transfer',
        args: [Result]
      }
    ]
  }
  ```
  
  ```bash
  truffle(ropsten)> instance.tokenURI(1)
  ```
  
  
