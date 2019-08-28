public struct OptionalType : _EquatableType {
    public struct Eq : Hashable {
        public var wrapped: TypeEquatableAdapter
        public init(_ x: OptionalType) {
            wrapped = x.wrapped.wrapInEquatable()
        }
    }
    
    public var wrapped: Type
    
    public init(_ wrapped: Type) {
        self.wrapped = wrapped
    }
    
    public func print(options: TypePrintOptions) -> String {
        let wr = wrapped.print(options: TypePrintOptions(isInOptional: true))
        return "\(wr)?"
    }
    
    public static func == (lhs: OptionalType, rhs: OptionalType) -> Bool {
        Eq(lhs) == Eq(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(Self.self))
        hasher.combine(Eq(self))
    }
    
    public func accept<V>(visitor: V) throws -> V.VisitResult where V : TypeVisitor {
        try visitor.visitOptionalType(self)
    }
}