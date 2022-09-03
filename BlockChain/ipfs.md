# IPFS

* `wget`을 사용해 다운로드

* 혹은 `.exe` 파일 이용

```url
https://docs.ipfs.tech/basics/command-line/#install-kubo
```

<br>

### 1. ipfs 설치

* ipfs설치 이전에 무조건 go lang을 다운로드 해야한다.

* Git Bash에서 go 버전이 확인 안되면 Window는 `cmd`환경에서 `go version` check
  
  ```url
  https://go.dev/
  ```

* 그 이후 ipfs를 설치하고 ipfs압축 해제이후 `ipfs.exe`파일을 go 파일 내부로 옮긴다.
  
  * 특이하게  `ProgramFiles/go/bin` 폴더로 옮겨준다.

<br>

### 2. IPFS 시작하기

```bash
$ ipfs init
```

```
generating ED25519 keypair...done
peer identity: 12D3KooWMunPnMjuDLXmSpcSChSphAYofgxghxpETpQ1sshnsXw2
initializing IPFS node at C:\Users\multicampus\.ipfs
to get started, enter:

        ipfs cat /ipfs/QmQPeNsJPyVWPFDVHb77w8G42Fvo15z4bG2X8D2GhfbSXc/readme
```

* 업로드
  
  ```bash
  $ ipfs add [파일경로]
  ```

* 경로확인
  
  ```bash
  $ ipfs config Addresses.API
  ```

* 데몬 실행
  
  ```bash
  $ ipfs daemon
  ```

* 접속
  
  ```url
  localhost:5001/webui
  ```

<br>

### 3. node에 환경 세팅

* 라이브러리 설치
  
  ```bash
  $ npm install --save ipfs-api
  ```

* js
  
  ```javascript
  const Web3 = require('web3');
  const fs = require('fs');
  const ipfsApi = require('ipfs-api');
  
  const ipfs = new ipfsApi('localhost', '5001', {protocol: 'http'});
  
  //StoreHash를 컴파일한 abi
  const Abi = [
  	{
  		"inputs": [
  			{
  				"internalType": "uint32[]",
  				"name": "_species",
  				"type": "uint32[]"
  			},
  			{
  				"internalType": "uint32[]",
  				"name": "_rank",
  				"type": "uint32[]"
  			},
  			{
  				"internalType": "string[]",
  				"name": "_ipfsURI",
  				"type": "string[]"
  			},
  			{
  				"internalType": "string[]",
  				"name": "_ipfsImage",
  				"type": "string[]"
  			},
  			{
  				"internalType": "uint256[]",
  				"name": "_number",
  				"type": "uint256[]"
  			}
  		],
  		"stateMutability": "nonpayable",
  		"type": "constructor"
  	},
  	{
  		"anonymous": false,
  		"inputs": [
  			{
  				"indexed": true,
  				"internalType": "address",
  				"name": "owner",
  				"type": "address"
  			},
  			{
  				"indexed": true,
  				"internalType": "address",
  				"name": "approved",
  				"type": "address"
  			},
  			{
  				"indexed": true,
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "Approval",
  		"type": "event"
  	},
  	{
  		"anonymous": false,
  		"inputs": [
  			{
  				"indexed": true,
  				"internalType": "address",
  				"name": "owner",
  				"type": "address"
  			},
  			{
  				"indexed": true,
  				"internalType": "address",
  				"name": "operator",
  				"type": "address"
  			},
  			{
  				"indexed": false,
  				"internalType": "bool",
  				"name": "approved",
  				"type": "bool"
  			}
  		],
  		"name": "ApprovalForAll",
  		"type": "event"
  	},
  	{
  		"anonymous": false,
  		"inputs": [
  			{
  				"indexed": true,
  				"internalType": "address",
  				"name": "previousOwner",
  				"type": "address"
  			},
  			{
  				"indexed": true,
  				"internalType": "address",
  				"name": "newOwner",
  				"type": "address"
  			}
  		],
  		"name": "OwnershipTransferred",
  		"type": "event"
  	},
  	{
  		"anonymous": false,
  		"inputs": [
  			{
  				"indexed": true,
  				"internalType": "address",
  				"name": "from",
  				"type": "address"
  			},
  			{
  				"indexed": true,
  				"internalType": "address",
  				"name": "to",
  				"type": "address"
  			},
  			{
  				"indexed": true,
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "Transfer",
  		"type": "event"
  	},
  	{
  		"inputs": [],
  		"name": "_createAnimalNFT",
  		"outputs": [
  			{
  				"internalType": "uint256",
  				"name": "",
  				"type": "uint256"
  			}
  		],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "_getMinter",
  		"outputs": [
  			{
  				"internalType": "address",
  				"name": "",
  				"type": "address"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "_getOwner",
  		"outputs": [
  			{
  				"internalType": "address",
  				"name": "",
  				"type": "address"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			},
  			{
  				"internalType": "address",
  				"name": "newOwner",
  				"type": "address"
  			}
  		],
  		"name": "_setOwner",
  		"outputs": [],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	},
  	{
  		"inputs": [],
  		"name": "_testImage",
  		"outputs": [
  			{
  				"internalType": "string",
  				"name": "",
  				"type": "string"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "address",
  				"name": "to",
  				"type": "address"
  			},
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "approve",
  		"outputs": [],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "address",
  				"name": "owner",
  				"type": "address"
  			}
  		],
  		"name": "balanceOf",
  		"outputs": [
  			{
  				"internalType": "uint256",
  				"name": "",
  				"type": "uint256"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "getApproved",
  		"outputs": [
  			{
  				"internalType": "address",
  				"name": "",
  				"type": "address"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "address",
  				"name": "owner",
  				"type": "address"
  			},
  			{
  				"internalType": "address",
  				"name": "operator",
  				"type": "address"
  			}
  		],
  		"name": "isApprovedForAll",
  		"outputs": [
  			{
  				"internalType": "bool",
  				"name": "",
  				"type": "bool"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [],
  		"name": "name",
  		"outputs": [
  			{
  				"internalType": "string",
  				"name": "",
  				"type": "string"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [],
  		"name": "owner",
  		"outputs": [
  			{
  				"internalType": "address",
  				"name": "",
  				"type": "address"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "ownerOf",
  		"outputs": [
  			{
  				"internalType": "address",
  				"name": "",
  				"type": "address"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [],
  		"name": "renounceOwnership",
  		"outputs": [],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "address",
  				"name": "from",
  				"type": "address"
  			},
  			{
  				"internalType": "address",
  				"name": "to",
  				"type": "address"
  			},
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "safeTransferFrom",
  		"outputs": [],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "address",
  				"name": "from",
  				"type": "address"
  			},
  			{
  				"internalType": "address",
  				"name": "to",
  				"type": "address"
  			},
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			},
  			{
  				"internalType": "bytes",
  				"name": "data",
  				"type": "bytes"
  			}
  		],
  		"name": "safeTransferFrom",
  		"outputs": [],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "address",
  				"name": "operator",
  				"type": "address"
  			},
  			{
  				"internalType": "bool",
  				"name": "approved",
  				"type": "bool"
  			}
  		],
  		"name": "setApprovalForAll",
  		"outputs": [],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "bytes4",
  				"name": "interfaceId",
  				"type": "bytes4"
  			}
  		],
  		"name": "supportsInterface",
  		"outputs": [
  			{
  				"internalType": "bool",
  				"name": "",
  				"type": "bool"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [],
  		"name": "symbol",
  		"outputs": [
  			{
  				"internalType": "string",
  				"name": "",
  				"type": "string"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "tokenURI",
  		"outputs": [
  			{
  				"internalType": "string",
  				"name": "",
  				"type": "string"
  			}
  		],
  		"stateMutability": "view",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "address",
  				"name": "from",
  				"type": "address"
  			},
  			{
  				"internalType": "address",
  				"name": "to",
  				"type": "address"
  			},
  			{
  				"internalType": "uint256",
  				"name": "tokenId",
  				"type": "uint256"
  			}
  		],
  		"name": "transferFrom",
  		"outputs": [],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	},
  	{
  		"inputs": [
  			{
  				"internalType": "address",
  				"name": "newOwner",
  				"type": "address"
  			}
  		],
  		"name": "transferOwnership",
  		"outputs": [],
  		"stateMutability": "nonpayable",
  		"type": "function"
  	}
  ];
  //console.log(Abi);
  
  const address = '0xD65cAbE3030F86d0818d803a4074edCb5212DD60'; //truffle migrate 했을때 출력되는 컨트랙트주소
  const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:7545'));
  //const web3 = new Web3(new Web3.providers.HttpProvider('http://20.196.209.2:8545'));
  //const web3 = new Web3(this.window.ethereum);
  
  const animalNFTContract = new web3.eth.Contract(Abi, address);
  
  const file_path = "./truffle/truffle-config.js";// ipfs에 추가할 파일명
  web3.eth.defaultAccount = "0x49192B6b4b1b4acAEF5BE5C5cba8F1A5ba1A4C55";
  //web3.eth.defaultAccount = "0x627306090abaB3A6e1400e9345bC60c78a8BEf57"; //트랜잭션을 처리할 계정
  //web3.eth.defaultAccount = "0x202933a3542ac61ca96dae70d848df3e8f824703b39a4cc0da77b8acd05838a6";
  // ipfs에 추가할 파일 읽어오기
  /*
  fs.readFile(file_path,'utf-8', function(err, data) {
    ipfs.files.add({ // ipfs에 파일추가
      path:'test',
      content: Buffer.from(data)
    }, async(err, fhash) => {
      //추가한 후 결과 값 확인
      //console.log(fhash[0]);
      console.log(fhash[0].hash);
      const file_hash = fhash[0].hash; // 파일을 추가한 후 해시값을 저장할 것이기 때문에 해시값 추출
      //bytes 자료형을 넣어야 하기 때문에 fromAscii로 형면환을 해줘야한다
      //sendHash 함수에 들어가는 파라미터는 인덱스 넘버와, 파일해시
      //await storehash.methods.sendHash(1, web3.utils.fromAscii(file_hash)).send({from:web3.eth.defaultAccount});
  
      // await storehash.methods.getHash(1).call().then(function(result){
      //   console.log('get: ' + web3.utils.toAscii(result)); // 해시값을 보기 위해서는 toAscii로 다시 형변환 해주어함
      // });
    });
  });
  */
  console.log("실행 전");
  console.log(animalNFTContract.methods);
  // const account = async () => {
  //   try {
  //     const res = await animalNFTContract.methods.getIPFS(1).call();
  //     console.log("들어왔나", res);
  //   } catch (err) {
  //     console.error(err);
  //   }
  // };
  // account();
  ```

* 똑같은 contract를 remix에 붙여놓고 상속 관계 다 삭제하고 배포한다음 ABI를 얻어내야 최신화가 된다.

* 
