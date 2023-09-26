//
//  RootLeakTracker.swift
//  
//
//  Created by Jeremy Bannister on 9/26/23.
//

///
public final class RootLeakTracker {
    
    ///
    public let name: String
    
    ///
    @MainActor
    private var trackedObjects: [(name: String?, weakReference: WeakReference<any AnyObject>)] = []
    
    ///
    public init (name: String) {
        self.name = name
    }
    
    ///
    @MainActor
    public func unreleasedObjects () -> [(name: String?, object: any AnyObject)] {
        
        ///
        var unreleasedObjects: [(String?, any AnyObject)] = []
        
        ///
        for i in trackedObjects.indices.reversed() {
            
            ///
            let (objectName, weakReference) = trackedObjects[i]
            
            ///
            if let object = weakReference.object {
                unreleasedObjects.append((objectName, object))
            } else {
                trackedObjects.remove(at: i)
            }
        }
        
        ///
        return unreleasedObjects.reversed()
    }
    
    ///
    @MainActor
    public func track
        (_ object: some AnyObject,
         name: String? = nil) {
        
        ///
        trackedObjects.append((name, .init(object)))
    }
    
    ///
    public var asLeakTracker: LeakTracker {
        .init(
            trackObject: {
                self.track(
                    $1,
                    name: $0.map { "\(self.name).\($0)" } ?? self.name
                )
            }
        )
    }
    
    ///
    @MainActor
    public func assertNoLeaks () throws {
        
        ///
        let leakCount = self.unreleasedObjects().count
        
        ///
        if leakCount > 0 {
            throw LeakCount(leakCount: leakCount)
        }
    }
    
    ///
    public struct LeakCount: Error {
        public let leakCount: Int
    }
}
