:autocmd Filetype dart set softtabstop=2
:autocmd Filetype dart set sw=2
:autocmd Filetype dart set ts=2

augroup fl_dart
  autocmd!
  autocmd Syntax dart highlight default link dartFlutterClasses     Type
  autocmd Syntax dart highlight default link dartFlutterTypedefs    Typedef
  autocmd Syntax dart highlight default link dartFlutterExceptions  Exception
  autocmd Syntax dart highlight default link dartFlutterConstants   Constant
  autocmd Syntax dart highlight default link dartFlutterEnums       Type
  autocmd Syntax dart highlight default link dartFlutterMixins      Type
  autocmd Syntax dart syntax keyword dartFlutterMixins
   \ AnimationEagerListenerMixin AnimationLazyListenerMixin
   \ AnimationLocalListenersMixin AnimationLocalStatusListenersMixin
   \ AnimationWithParentMixin AutomaticKeepAliveClientMixin LocalHistoryRoute
   \ PaintingBinding SingleTickerProviderStateMixin TickerProviderStateMixin
   \ ViewportNotificationMixin WidgetInspectorService WidgetsBinding
  autocmd Syntax dart syntax keyword dartFlutterEnums
   \ AnimationBehavior AnimationStatus AppLifecycleState Axis AxisDirection
   \ BannerLocation BlendMode BlurStyle BorderStyle BoxFit BoxShape Clip
   \ ConnectionState CrossAxisAlignment CrossFadeState DecorationPosition
   \ DiagnosticLevel DismissDirection DragAnchor FadeInImagePhase FilterQuality
   \ FlexFit FlutterLogoStyle FontStyle GrowthDirection HeroFlightDirection
   \ HitTestBehavior ImageRepeat MainAxisAlignment MainAxisSize Orientation
   \ Overflow PaintingStyle PathFillType PathOperation RenderComparison
   \ RoutePopDisposition SelectionChangedCause StackFit StrokeCap StrokeJoin
   \ TableCellVerticalAlignment TargetPlatform TextAffinity TextAlign
   \ TextBaseline TextDecorationStyle TextDirection TextOverflow
   \ TextSelectionHandleType TileMode VertexMode VerticalDirection WrapAlignment
   \ WrapCrossAlignment
  autocmd Syntax dart syntax keyword dartFlutterConstants
   \ immutable kAlwaysCompleteAnimation kAlwaysDismissedAnimation mustCallSuper
   \ optionalTypeArgs protected required visibleForTesting
  autocmd Syntax dart syntax keyword dartFlutterExceptions
   \ FlutterError TickerCanceled
  autocmd Syntax dart syntax keyword dartFlutterTypedefs
   \ AnimatedCrossFadeBuilder AnimatedListItemBuilder
   \ AnimatedListRemovedItemBuilder AnimatedSwitcherLayoutBuilder
   \ AnimatedSwitcherTransitionBuilder AnimationStatusListener
   \ AsyncWidgetBuilder ControlsWidgetBuilder CreateRectTween
   \ DismissDirectionCallback DragEndCallback DraggableCanceledCallback
   \ DragTargetAccept DragTargetBuilder DragTargetLeave DragTargetWillAccept
   \ ElementVisitor ErrorWidgetBuilder FormFieldBuilder FormFieldSetter
   \ FormFieldValidator GenerateAppTitle GestureDragCancelCallback
   \ GestureDragDownCallback GestureDragEndCallback GestureDragStartCallback
   \ GestureDragUpdateCallback GestureLongPressCallback
   \ GestureRecognizerFactoryConstructor GestureRecognizerFactoryInitializer
   \ GestureScaleEndCallback GestureScaleStartCallback
   \ GestureScaleUpdateCallback GestureTapCallback GestureTapCancelCallback
   \ GestureTapDownCallback GestureTapUpCallback HeroFlightShuttleBuilder
   \ ImageErrorListener ImageListener IndexedWidgetBuilder
   \ InspectorSelectButtonBuilder InspectorSelectionChangedCallback
   \ LayoutWidgetBuilder LocaleListResolutionCallback LocaleResolutionCallback
   \ NestedScrollViewHeaderSliversBuilder NotificationListenerCallback
   \ OrientationWidgetBuilder PageRouteFactory PointerCancelEventListener
   \ PointerDownEventListener PointerMoveEventListener PointerUpEventListener
   \ RebuildDirtyWidgetCallback RouteFactory RoutePageBuilder RoutePredicate
   \ RouteTransitionsBuilder ScrollNotificationPredicate
   \ SelectionChangedCallback SemanticIndexCallback SemanticsBuilderCallback
   \ ShaderCallback StatefulWidgetBuilder StateSetter
   \ TextSelectionOverlayChanged TransitionBuilder TweenConstructor TweenVisitor
   \ ValueChanged ValueGetter ValueSetter ValueWidgetBuilder ViewportBuilder
   \ VoidCallback WidgetBuilder WillPopCallback
  autocmd Syntax dart syntax keyword dartFlutterClasses
   \ AbsorbPointer Align Alignment AlignmentDirectional AlignmentGeometry
   \ AlignmentGeometryTween AlignmentTween AlignTransition AlwaysScrollableScrollPhysics
   \ AlwaysStoppedAnimation AndroidView Animatable AnimatedAlign AnimatedBuilder
   \ AnimatedContainer AnimatedCrossFade AnimatedDefaultTextStyle AnimatedList
   \ AnimatedListState AnimatedModalBarrier AnimatedOpacity AnimatedPadding
   \ AnimatedPhysicalModel AnimatedPositioned AnimatedPositionedDirectional AnimatedSize
   \ AnimatedSwitcher AnimatedWidget AnimatedWidgetBaseState Animation AnimationController
   \ AnimationMax AnimationMean AnimationMin AnnotatedRegion AspectRatio
   \ AssetBundleImageProvider AssetImage AsyncSnapshot AutomaticKeepAlive BackdropFilter
   \ BallisticScrollActivity Banner BannerPainter Baseline BeveledRectangleBorder
   \ BlockSemantics Border BorderDirectional BorderRadius BorderRadiusDirectional
   \ BorderRadiusGeometry BorderRadiusTween BorderSide BorderTween BottomNavigationBarItem
   \ BouncingScrollPhysics BouncingScrollSimulation BoxBorder BoxConstraints
   \ BoxConstraintsTween BoxDecoration BoxPainter BoxScrollView BoxShadow BuildContext
   \ Builder BuildOwner Canvas Center ChangeNotifier CheckedModeBanner CircleBorder
   \ CircularNotchedRectangle ClampingScrollPhysics ClampingScrollSimulation ClipContext
   \ ClipOval ClipPath ClipRect ClipRRect Color ColorFilter ColorSwatch ColorTween
   \ Column ComponentElement CompositedTransformFollower CompositedTransformTarget
   \ CompoundAnimation ConstantTween ConstrainedBox Container Cubic Curve
   \ CurvedAnimation Curves CurveTween CustomClipper CustomMultiChildLayout
   \ CustomPaint CustomPainter CustomPainterSemantics CustomScrollView
   \ CustomSingleChildLayout DecoratedBox DecoratedBoxTransition Decoration
   \ DecorationImage DecorationImagePainter DecorationTween DefaultAssetBundle
   \ DefaultTextStyle DefaultTextStyleTransition DefaultWidgetsLocalizations
   \ Directionality Dismissible DragDownDetails DragEndDetails Draggable
   \ DraggableDetails DragScrollActivity DragStartDetails DragTarget
   \ DragUpdateDetails DrivenScrollActivity EdgeInsets EdgeInsetsDirectional
   \ EdgeInsetsGeometry EdgeInsetsGeometryTween EdgeInsetsTween EditableText
   \ EditableTextState ElasticInCurve ElasticInOutCurve ElasticOutCurve Element
   \ ErrorWidget ExactAssetImage ExcludeSemantics Expanded FadeInImage
   \ FadeTransition FileImage FittedBox FittedSizes FixedColumnWidth
   \ FixedExtentMetrics FixedExtentScrollController FixedExtentScrollPhysics
   \ FixedScrollMetrics Flex FlexColumnWidth Flexible FlippedCurve Flow
   \ FlowDelegate FlowPaintingContext FlutterErrorDetails FlutterLogoDecoration
   \ FocusManager FocusNode FocusScope FocusScopeNode FontWeight Form FormField
   \ FormFieldState FormState FractionallySizedBox FractionalOffset
   \ FractionalOffsetTween FractionalTranslation FractionColumnWidth
   \ FutureBuilder GestureDetector GestureRecognizerFactory AssetBundleImageKey
   \ GestureRecognizerFactoryWithHandlers GlobalKey GlobalObjectKey
   \ GlowingOverscrollIndicator Gradient GridPaper GridView Hero HeroController
   \ HoldScrollActivity HSLColor HSVColor Icon IconData IconTheme IconThemeData
   \ IdleScrollActivity IgnorePointer Image ImageCache ImageConfiguration
   \ ImageIcon ImageInfo ImageProvider ImageShader ImageStream
   \ ImageStreamCompleter ImplicitlyAnimatedWidget ImplicitlyAnimatedWidgetState
   \ IndexedSemantics IndexedStack InheritedElement InheritedModel
   \ InheritedModelElement InheritedNotifier InheritedWidget InspectorSelection
   \ Interval IntrinsicColumnWidth IntrinsicHeight IntrinsicWidth IntTween
   \ KeepAlive KeepAliveHandle KeepAliveNotification Key KeyedSubtree
   \ LabeledGlobalKey LayerLink LayoutBuilder LayoutChangedNotification LayoutId
   \ LeafRenderObjectElement LeafRenderObjectWidget LimitedBox LinearGradient
   \ ListBody Listenable Listener ListView ListWheelChildBuilderDelegate
   \ ListWheelChildDelegate ListWheelChildListDelegate
   \ ListWheelChildLoopingListDelegate ListWheelElement ListWheelScrollView
   \ ListWheelViewport Locale LocalHistoryEntry Localizations
   \ LocalizationsDelegate LocalKey LongPressDraggable MaskFilter Matrix4
   \ Matrix4Tween MatrixUtils MaxColumnWidth MediaQuery MediaQueryData
   \ MemoryImage MergeSemantics MetaData MinColumnWidth ModalBarrier ModalRoute
   \ MultiChildLayoutDelegate MultiChildRenderObjectElement
   \ MultiChildRenderObjectWidget MultiFrameImageStreamCompleter
   \ NavigationToolbar Navigator NavigatorObserver NavigatorState
   \ NestedScrollView NestedScrollViewViewport NetworkImage
   \ NeverScrollableScrollPhysics NotchedShape Notification NotificationListener
   \ ObjectKey Offset Offstage OneFrameImageStreamCompleter Opacity
   \ OrientationBuilder OverflowBox Overlay OverlayEntry OverlayRoute
   \ OverlayState OverscrollIndicatorNotification OverscrollNotification Padding
   \ PageController PageMetrics PageRoute PageRouteBuilder PageScrollPhysics
   \ PageStorage PageStorageBucket PageStorageKey PageView Paint PaintingContext
   \ ParentDataElement ParentDataWidget Path PerformanceOverlay PhysicalModel
   \ PhysicalShape Placeholder PointerCancelEvent PointerDownEvent PointerEvent
   \ PointerMoveEvent PointerUpEvent PopupRoute Positioned PositionedDirectional
   \ PositionedTransition PreferredSize PreferredSizeWidget
   \ PrimaryScrollController ProxyAnimation ProxyElement ProxyWidget
   \ RadialGradient Radius RawGestureDetector RawGestureDetectorState RawImage
   \ RawKeyboardListener RawKeyEvent Rect RectTween RelativePositionedTransition
   \ RelativeRect RelativeRectTween RenderBox RenderNestedScrollViewViewport
   \ RenderObject RenderObjectElement RenderObjectToWidgetAdapter
   \ RenderObjectToWidgetElement RenderObjectWidget RenderSliverOverlapAbsorber
   \ RenderSliverOverlapInjector RepaintBoundary ReverseAnimation ReverseTween
   \ RichText RootRenderObjectElement RotatedBox RotationTransition
   \ RoundedRectangleBorder Route RouteAware RouteObserver RouteSettings Row
   \ RRect RSTransform SafeArea SawTooth ScaleEndDetails ScaleStartDetails
   \ ScaleTransition ScaleUpdateDetails Scrollable ScrollableState
   \ ScrollActivity ScrollActivityDelegate ScrollbarPainter ScrollBehavior
   \ ScrollConfiguration ScrollContext ScrollController ScrollDragController
   \ ScrollEndNotification ScrollHoldController ScrollMetrics ScrollNotification
   \ ScrollPhysics ScrollPosition ScrollPositionWithSingleContext
   \ ScrollSpringSimulation ScrollStartNotification ScrollUpdateNotification
   \ ScrollView Semantics SemanticsDebugger Shader ShaderMask Shadow ShapeBorder
   \ ShapeBorderClipper ShapeDecoration ShrinkWrappingViewport Simulation
   \ SingleChildLayoutDelegate SingleChildRenderObjectElement
   \ SingleChildRenderObjectWidget SingleChildScrollView Size
   \ SizeChangedLayoutNotification SizeChangedLayoutNotifier SizedBox
   \ SizedOverflowBox SizeTransition SizeTween SlideTransition
   \ SliverChildBuilderDelegate SliverChildDelegate SliverChildListDelegate
   \ SliverFillRemaining SliverFillViewport SliverFixedExtentList SliverGrid
   \ SliverGridDelegate SliverGridDelegateWithFixedCrossAxisCount
   \ SliverGridDelegateWithMaxCrossAxisExtent SliverList
   \ SliverMultiBoxAdaptorElement SliverMultiBoxAdaptorWidget
   \ SliverOverlapAbsorber SliverOverlapAbsorberHandle SliverOverlapInjector
   \ SliverPadding SliverPersistentHeader SliverPersistentHeaderDelegate
   \ SliverPrototypeExtentList SliverSafeArea SliverToBoxAdapter
   \ SliverWithKeepAliveWidget Spacer Stack StadiumBorder State StatefulBuilder
   \ StatefulElement StatefulWidget StatelessElement StatelessWidget
   \ StatusTransitionWidget StepTween StreamBuilder StreamBuilderBase
   \ SweepGradient Table TableBorder TableCell TableColumnWidth TableRow
   \ TapDownDetails TapUpDetails Text TextBox TextDecoration
   \ TextEditingController TextEditingValue TextInputType TextPainter
   \ TextPosition TextRange TextSelection TextSelectionControls
   \ TextSelectionDelegate TextSelectionOverlay TextSpan TextStyle
   \ TextStyleTween Texture Threshold TickerFuture TickerMode TickerProvider
   \ Title Tolerance TrackingScrollController TrainHoppingAnimation Transform
   \ TransformProperty TransitionRoute Tween TweenSequence TweenSequenceItem
   \ TypeMatcher UiKitView UnconstrainedBox UniqueKey UniqueWidget
   \ UserScrollNotification ValueKey ValueListenableBuilder ValueNotifier
   \ Velocity Viewport Visibility Widget WidgetInspector WidgetsApp
   \ WidgetsBindingObserver WidgetsFlutterBinding WidgetsLocalizations
   \ WidgetToRenderBoxAdapter WillPopScope Wrap Scaffold AppBar
   \ Icons PopupMenuItem IconButton GridTile Theme Colors GridTileBar
   \ CircleAvatar Divider ListTile RefreshIndicator Future MaterialApp
   \ MaterialPageRouter Dio Provider 
augroup end
