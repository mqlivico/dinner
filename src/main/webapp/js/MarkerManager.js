/**
 * @fileoverview Marker Manager ��ע������
 * ���������<a href="symbols/BMapLib.MarkerManager.html">MarkerManager</a>��
 * ����Baidu Map API 1.2��
 *
 * @author Baidu Map Api Group
 * @version 1.2
 */
/**
 * @namespace BMap������library�������BMapLib�����ռ���
 */
var BMapLib = window.BMapLib = BMapLib || {};
(function () {
	var T,
    baidu = T = baidu || {version: "1.5.1"};
	baidu.guid = "$BAIDU$";
	(function(){
		window[baidu.guid] = window[baidu.guid] || {};
		baidu.object = baidu.object || {};
		baidu.extend =
		baidu.object.extend = function (target, source) {
		    for (var p in source) {
		        if (source.hasOwnProperty(p)) {
		            target[p] = source[p];
		        }
		    }

		    return target;
		};
		T.undope=true;
	})();
	/**
     * @exports MarkerManager as BMapLib.MarkerManager
     */

    var MarkerManager =
    /**
     * MarkerManger��Ĺ��캯��
     * @class MarkerManager <b>���</b>��
     * ʵ��������󣬿ɵ���addMarkers,show,hide�ȷ���������marker��
     * ��ע�⣬����Ƚ����������������
     * ����marker�ֲ�����ͬ��zoom�����У����磺18����ʱ����ʾ100��marker��15����ʱ����ʾ�����100��marker
     * @constructor
	     * @param {Map} map Baidu map��ʵ������.
	     * @param {Json Object} opts ��ѡ������������Ǳ����������ѡ�������<br />
	     * {<br />"<b>borderPadding</b>" : {Number} ��ǰviewport�����padding���������padding�е�marker�ᱻ��ӵ���ͼ�ϣ���ʹ���ǲ�����ȫ�ɼ��ġ�
	     * <br />"<b>maxZoom</b>" : {Number} ������Ҫmarker manager��Ҫ���ӵ�����zoom�����û�и�����Ĭ��Ϊ��ͼ������zoom��.
	     *<br />
	     * }<br />.
	     * @example <b>�ο�ʾ����</b><br />
	     * var mgr = new BMapLib.MarkerManager(map,{borderPadding: padding,maxZoom: 18,trackMarkers: true});
     */
    BMapLib.MarkerManager = function (map, opts) {
            this._opts = opts || {};
            this._map = map;
            this._zoom = map.getZoom();
            //���ڴ����ӵ�marker����
            this._numMarkers = [];

            if (typeof opts.maxZoom === 'number') {
                this._opts.maxZoom = this._opts.maxZoom;
            } else {
                this._opts.maxZoom = 19;
            }
            if (typeof opts.borderPadding === 'number') {
                this._opts.borderPadding = opts.borderPadding;
            } else {
                this._opts.borderPadding = 0;
            }

            var me = this;
            //��zoomend�¼�
            this._map.addEventListener("zoomend", function () {
                //me._visible && me._showMarkers();
                me._showMarkers();
            });
            //��dragend�¼�
            this._map.addEventListener("dragend", function () {
                //me._visible && me._showMarkers();
                me._showMarkers();
            });
        }
    /**
     * ��ӵ���marker
     * @param {Marker} marker Ҫ��ӵ�marker
     * @param {Number} minZoom ����ͼ���ŵ�С�ڴ�zoom��ʱ��marker������ص���ͼ��
     * @param {Number} maxZoom ����ͼ���ŵ����ڴ�zoom��ʱ��marker������ص���ͼ��
     * @return none
     *
     * @example <b>�ο�ʾ����</b><br />
     * mgr.addMarker(marker,4,15);
     */
    MarkerManager.prototype.addMarker = function (marker, minZoom, maxZoom) {
        minZoom = minZoom && minZoom > 0 ? minZoom : 1;
        maxZoom = maxZoom && maxZoom <= 19 ? maxZoom : this._opts.maxZoom;
        marker.minZoom = minZoom;
        marker.maxZoom = maxZoom;
        marker.bAdded = false;
        this._numMarkers.push(marker);
        marker.enableDragging();
    }
        /**
         * �������marker
         * @param {Array} markers Ҫ��ӵ�marker����
         * @param {Number} minZoom ����ͼ���ŵ�С�ڴ�zoom��ʱ��marker������ص���ͼ��
         * @param {Number} maxZoom ����ͼ���ŵ����ڴ�zoom��ʱ��marker������ص���ͼ��
         * @return none
         *
         * @example <b>�ο�ʾ����</b><br />
         * mgr.addMarker(markers,4,15);
         */
        MarkerManager.prototype.addMarkers = function (markers, minZoom, maxZoom) {
            var len = markers.length,
                me = this;
            for (var i = len; i--;) {
                this.addMarker(markers[i], minZoom, maxZoom);
            }
        }
        /**
         * ��manager����ͼ�У��Ƴ�marker����������ڿɼ���
         * @param {Marker} marker Ҫɾ����marker
         * @return none
         *
         * @example <b>�ο�ʾ����</b><br />
         * mgr.removeMarker(Marker);
         */
        MarkerManager.prototype.removeMarker = function (marker) {
            if (marker instanceof BMap.Marker) {
                //�Ƴ���ͼ�ϵ�marker
                this._map.removeOverlay(marker);
                //�Ƴ�markerManager�е�marker
                this._removeMarkerFromArray(marker);
            }
        }
        /**
         * ���ش�zoom�¿ɼ�marker������
         * @param {Number} zoom ��ͼ���ż���
         * @return none
         *
         * @example <b>�ο�ʾ����</b><br />
         * mgr.getMarkerCount(15);
         */
        MarkerManager.prototype.getMarkerCount = function (zoom) {
            var len = this._numMarkers.length,
                t = this._numMarkers,
                count = 0;
            for (var i = len; i--;) {
                count = t[i].bInBounds ? ((t[i].minZoom <= zoom && t[i].maxZoom >= zoom) ? ++count : count) : count;
            }
			//������ص�����marker��marker����Ϊ0
            return this._visible ? count : 0;
        }
        /**
         * ��ʾmarker,�˷���ֻ�ǿ���css��ʽ�е�display��ֵ��
         * @return none
         *
         * @example <b>�ο�ʾ����</b><br />
         * mgr.show();
         */
        MarkerManager.prototype.show = function () {
            var num = this._numMarkers.length;
            for (var i = num; i--;) {
                //����Ұ�е�marker��ʾ
                this._numMarkers[i].bInBounds && this._numMarkers[i].show();
            }
            this._visible = true;
        }
        /**
         * ����marker���˷���ֻ�ǿ���css��ʽ�е�display��ֵ��
         * @return none
         *
         * @example <b>�ο�ʾ����</b><br />
         * mgr.hide();
         */
        MarkerManager.prototype.hide = function () {
            var num = this._numMarkers.length;
            for (var i = num; i--;) {
                this._numMarkers[i].bInBounds && this._numMarkers[i].hide();
            }
            this._visible = false;
        }
        /**
         * ��ʾ��������marker
         * @param {Marker} marker Ҫɾ����marker
         * @return none
         *
         * @example <b>�ο�ʾ����</b><br />
         * mgr.toggle(marker,4,15);
         */
        MarkerManager.prototype.toggle = function () {
            this._visible ? this.hide() : this.show();
        }
        /**
         * ��ʾ��ͼ�ϵ�marker
         * @return none
         *
         * @example <b>�ο�ʾ����</b><br />
         * mgr.showMarkers();
         */
        MarkerManager.prototype.showMarkers = function () {
            this._visible = true;
            this._showMarkers();
        }
        /**
         * �Ƴ���manager�е�����marker,����ա�
         * @param none
         * @return none
         *
         * @example <b>�ο�ʾ����</b><br />
         * mgr.clearMarkers();
         */
        MarkerManager.prototype.clearMarkers = function () {
            var len = this._numMarkers.length;
            for (var i = len; i--;) {
                this._numMarkers[i].bInBounds && this._map.removeOverlay(this._numMarkers[i]);
            }
            this._numMarkers.length = 0;
        }
    baidu.object.extend(MarkerManager.prototype, {
        _showMarkers: function () {
            var num = this._numMarkers.length,
                curZoom = this._map.getZoom(),
                t = this._numMarkers,
                curBounds = this._getRealBounds();
            for (var i = num; i--;) {
                //�ڿ��������� && ��ǰzoom����marker����ʾ����
                if (curBounds.containsPoint(t[i].getPosition()) && curZoom >= t[i].minZoom && curZoom <= t[i].maxZoom) {
                    t[i].bInBounds = true;
                    //û�б���ӵ���ͼ
                    if(!t[i].bAdded){
	                    this._map.addOverlay(t[i]);
	                    !this._visible && t[i].hide();
	                    t[i].bAdded = true;
	                }else{
	                	//��ʾmarker
						this._visible && t[i].show();
	                }
                } else if(t[i].bAdded){
                    // ��ǰ��ͼzoomС��marker����Сzoom���ߴ������zoom,�����Ѿ�����ӵ���ͼ�ϡ��ͽ���marker����
                    t[i].bInBounds = false;
                    //this._map.removeOverlay(t[i]);
                    t[i].hide();
                }
            }
        },
        /**
         * �õ�ʵ�ʵ�bound��Χ
         * @return none
         */
        _getRealBounds: function () {
            var curBounds = this._map.getBounds(),
                southWest = this._map.pointToPixel(curBounds.getSouthWest()),
                northEast = this._map.pointToPixel(curBounds.getNorthEast()),
                extendSW = {
                    x: southWest.x - this._opts.borderPadding,
                    y: southWest.y + this._opts.borderPadding
                },
                extendNE = {
                    x: northEast.x + this._opts.borderPadding,
                    y: northEast.y - this._opts.borderPadding
                },
                extendSwPoint = this._map.pixelToPoint(extendSW),
                extendNePoint = this._map.pixelToPoint(extendNE);
            return new BMap.Bounds(extendSwPoint, extendNePoint);
        },
        /**
         * ��������ɾ��marker
         * @param {Marker} marker Ҫɾ����marker
         * @return {String} ��ɾ����marker������
         */
        _removeMarkerFromArray: function (marker) {
            var num = this._numMarkers.length,
                i = num,
                shift = 0;
            for (i = num; i--;) {
                if (marker === this._numMarkers[i]) {
                    this._numMarkers.splice(i--, 1)
                    shift++;
                }
            }
            return shift;
        }
    });
})();
