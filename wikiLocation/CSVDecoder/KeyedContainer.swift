//
//  KeyedContainer.swift
//  CSVDecoder
//
//  Created by Red Davis on 15/02/2019.
//  Copyright © 2019 Red Davis. All rights reserved.
//

import Foundation

internal extension _CSVDecoder {
    final class KeyedContainer<Key> where Key: CodingKey {
        let codingPath: [CodingKey]
        
        // Private
        private let headers: [Header]
        private let values: [String]
        
        // MARK: Initialization
        
        required init(headers: [Header], row: String, codingPath: [CodingKey]) {
            self.headers = headers
            self.codingPath = codingPath
            self.values = row.split(separator: ",").map({ (substring) -> String in
                if let regex = try? NSRegularExpression(pattern: "\"(.*?)\"", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: String(substring), options: [], range: NSRange(location: 0, length:  substring.count), withTemplate: "$1")
                    return modString
                }
                return String(substring)
            })
        }
    }
}

// MARK: KeyedDecodingContainerProtocol

extension _CSVDecoder.KeyedContainer: KeyedDecodingContainerProtocol {
    var allKeys: [Key] {
        return self.headers.compactMap({ (header) -> Key? in
            return Key(stringValue: header.key)
        })
    }
    
    func contains(_ key: Key) -> Bool {
        let header = self.headers.first { (header) -> Bool in
            return header.key == key.stringValue
        }
        
        guard let unwrappedHeader = header,
              unwrappedHeader.index < self.values.count,
              !self.values[unwrappedHeader.index].isEmpty else {
            return false
        }
        
        return true
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        return !self.contains(key)
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        let header = self.headers.first { (header) -> Bool in
            return header.key == key.stringValue
        }
        
        guard let unwrappedHeader = header else {
            let context = DecodingError.Context(codingPath: self.codingPath, debugDescription: "Values: \(self.values) Headers: \(self.headers)")
            throw DecodingError.keyNotFound(key, context)
        }
        
        return self.values[unwrappedHeader.index]
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable, T: LosslessStringConvertible {
        let string = try self.decode(String.self, forKey: key)
        guard let value = T(string) else {
            let context = DecodingError.Context(codingPath: self.codingPath, debugDescription: "Components: \(self.values) Headers: \(self.headers)")
            throw DecodingError.typeMismatch(type, context)
        }
        
        return value
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        let row = self.values.joined()
        let decoder = _CSVDecoder(headers: self.headers, rows: [row])
        let value = try T(from: decoder)

        return value
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        fatalError("Unimplemented")
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        fatalError("Unimplemented")
    }
    
    func superDecoder() throws -> Decoder {
        fatalError("Unimplemented")
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        fatalError("Unimplemented")
    }
}
