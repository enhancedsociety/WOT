import "./Whitelist.sol";

contract Trustery is Whitelist {
    struct Attribute {
        address owner;
        string attributeType;
        string data;
        string datahash;
    }

    struct Signature {
        address signer;
        uint attributeID;
        uint expiry;
    }

    struct Revocation {
        uint signatureID;
    }

    Attribute[] public attributes;
    Signature[] public signatures;
    Revocation[] public revocations;

    event AttributeAdded(uint indexed attributeID, address indexed owner, string attributeType, string data, string datahash);
    event AttributeSigned(uint indexed signatureID, address indexed signer, uint indexed attributeID, uint expiry);
    event SignatureRevoked(uint indexed revocationID, uint indexed signatureID);

   function iswhitelist(address sender) private returns (bool) {
        Whitelist dc;
        address contract_addr = 0x480d9836ad15554245b291e32487bcb230f69be3;
        dc = Whitelist(contract_addr);
        return (dc.whitelist(sender));
    }

    function addAttribute(string attributeType, string data, string datahash) onlyOwner returns (uint attributeID) {
        
        // call the iswhitelist function to verify msg.sender
        require (iswhitelist(msg.sender));
    
        attributeID = attributes.length++;
        Attribute attribute = attributes[attributeID];
        attribute.owner = msg.sender;
        attribute.attributeType = attributeType;
        attribute.data = data;
        attribute.datahash = datahash;
        AttributeAdded(attributeID, msg.sender, attributeType, data, datahash);
    }

    
    function signAttribute(uint attributeID, uint expiry) returns (uint signatureID) {
        
         // call the iswhitelist function to verify msg.sender
        require (iswhitelist(msg.sender));
        
        signatureID = signatures.length++;
        Signature signature = signatures[signatureID];
        signature.signer = msg.sender;
        signature.attributeID = attributeID;
        signature.expiry = expiry;
        AttributeSigned(signatureID, msg.sender, attributeID, expiry);
    }

    function revokeSignature(uint signatureID) returns (uint revocationID) {
        if (signatures[signatureID].signer == msg.sender) {
            revocationID = revocations.length++;
            Revocation revocation = revocations[revocationID];
            revocation.signatureID = signatureID;
            SignatureRevoked(revocationID, signatureID);
        }
    }
}
