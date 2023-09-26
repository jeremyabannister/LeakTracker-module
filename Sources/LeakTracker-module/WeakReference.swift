//
//  WeakReference.swift
//  
//
//  Created by Jeremy Bannister on 9/26/23.
//

///
public final class WeakReference <Object: AnyObject> {
    
    ///
    @MainActor
    public private(set) weak var object: Object?
    
    ///
    public init (_ object: Object) {
        self.object = object
    }
    
    ///
    @MainActor
    public var isReleased: Bool { object == nil }
}
