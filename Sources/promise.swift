
public class Promise<S,T>
{
	public var value: T? = nil
	public var getValue: (S) -> T?

	public init (_ resolve: @escaping (S) -> T?)
	{
		self.getValue = resolve
	}

	public func resolve(_ arg: S)
	{
		self.value = self.getValue(arg)
	}

	public func then<U>(_ chained: @escaping (T?) -> U?) -> Promise<S, U?>
	{
		return Promise<S, U?> { (arg: S) in
			self.resolve(arg)
			return chained(self.value)
		}
	}
}
